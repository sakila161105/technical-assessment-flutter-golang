import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  static const Color red = Color(0xffd50000);

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<OrderProvider>().fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final order = context.watch<OrderProvider>();

    final pendapatan = order.totalPendapatan;

    final jumlahOrder = order.totalOrder;

    final selesai = order.totalSelesai;

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),

      appBar: AppBar(
        title: const Text("Laporan Usaha"),

        backgroundColor: red,

        foregroundColor: Colors.white,
      ),

      body: order.loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(18),

              child: Column(
                children: [
                  _card(
                    "Pendapatan",

                    "Rp $pendapatan",

                    Colors.green,

                    Icons.arrow_upward,
                  ),

                  _card(
                    "Total Pesanan",

                    "$jumlahOrder Transaksi",

                    Colors.blue,

                    Icons.shopping_bag,
                  ),

                  _card(
                    "Pesanan Selesai",

                    "$selesai Order",

                    Colors.orange,

                    Icons.check_circle,
                  ),

                  const SizedBox(height: 20),

                  Container(
                    height: 220,

                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const Icon(Icons.show_chart, size: 60, color: red),

                        const SizedBox(height: 10),

                        const Text(
                          "Grafik Penjualan",

                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Data dari $jumlahOrder transaksi",

                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _card(String title, String value, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(.2),

            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(title),

              Text(
                value,

                style: const TextStyle(
                  fontSize: 18,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
