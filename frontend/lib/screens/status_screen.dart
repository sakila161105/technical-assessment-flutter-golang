import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  static const Color primaryRed = Color(0xFFD50000);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderProvider>();
    final orders = provider.filteredOrders;

    final selesai = orders.where((e) => e["status"] == "Selesai").length;
    final terlambat = 0;
    final harusSelesai = orders.where((e) => e["status"] == "Diproses").length;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
        title: const Text(
          "Status Orderan",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 90),
        children: [
          Row(
            children: [
              Image.asset(
                "assets/maskot/outlet_pro_mascot.png",
                height: 58,
                errorBuilder: (_, __, ___) {
                  return const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFFFEBEE),
                    child: Icon(Icons.local_laundry_service, color: primaryRed),
                  );
                },
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hai, Mewing Laundry",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Ini pesanan yang harus kamu selesaikan",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          _statusCard(
            context: context,
            title: "Selesai",
            count: selesai,
            color: const Color(0xFF6F2DBD),
            imagePath: "assets/icons/ic_status_selesai.webp",
            fallbackIcon: Icons.check_circle,
          ),

          const SizedBox(height: 18),

          _statusCard(
            context: context,
            title: "Terlambat",
            count: terlambat,
            color: const Color(0xFFD50000),
            imagePath: "assets/icons/ic_siapambil.webp",
            fallbackIcon: Icons.warning_amber_rounded,
          ),

          const SizedBox(height: 18),

          _statusCard(
            context: context,
            title: "Harus Selesai",
            count: harusSelesai,
            color: const Color(0xFFF2C94C),
            imagePath: "assets/icons/ic_proses.webp",
            fallbackIcon: Icons.today,
          ),
        ],
      ),
    );
  }

  Widget _statusCard({
    required BuildContext context,
    required String title,
    required int count,
    required Color color,
    required String imagePath,
    required IconData fallbackIcon,
  }) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.30),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -28,
            top: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -18,
            bottom: -28,
            child: Container(
              width: 210,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.12),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),

          Positioned(
            right: 18,
            top: 34,
            child: Image.asset(
              imagePath,
              height: 72,
              width: 72,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) {
                return Icon(
                  fallbackIcon,
                  color: Colors.white.withOpacity(0.80),
                  size: 70,
                );
              },
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: 76,
                height: 76,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: Text(
                  "$count",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            right: 2,
            bottom: 8,
            child: OutlinedButton.icon(
              onPressed: () {
                _showStatusDetail(context, title, count);
              },
              icon: const Icon(Icons.arrow_forward_ios, size: 15),
              label: const Text(
                "Lihat Detail",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.black, width: 1.6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 9,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showStatusDetail(BuildContext context, String title, int count) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Total orderan: $count",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "Detail daftar orderan dapat dikembangkan pada tahap berikutnya.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}