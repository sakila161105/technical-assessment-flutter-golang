import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  static const Color primaryRed = Color(0xffd50000);

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

    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),

      appBar: AppBar(
        title: const Text("History Transaksi"),

        backgroundColor: primaryRed,

        foregroundColor: Colors.white,
      ),

      body: order.loading
          ? const Center(child: CircularProgressIndicator())
          : order.allOrders.isEmpty
          ? const Center(child: Text("Belum ada transaksi"))
          : ListView.builder(
              padding: const EdgeInsets.all(18),

              itemCount: order.allOrders.length,

              itemBuilder: (context, index) {
                final item = order.allOrders[index];

                return _item(
                  item["code"].toString(),

                  item["service"].toString(),

                  item["price"],

                  item["status"].toString(),
                );
              },
            ),
    );
  }

  Widget _item(String kode, String layanan, dynamic harga, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                kode,

                style: const TextStyle(
                  color: primaryRed,

                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(layanan),

              const SizedBox(height: 5),

              Text(
                status,

                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),

          Text(
            "Rp ${harga.toString()}",

            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
