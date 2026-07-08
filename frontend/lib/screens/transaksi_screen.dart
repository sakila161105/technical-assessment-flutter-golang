import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import 'form_order_screen.dart';
import 'detail_order_screen.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  static const Color primaryRed = Color(0xffd50000);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderProvider>();

    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),

      appBar: AppBar(
        backgroundColor: primaryRed,

        foregroundColor: Colors.white,

        title: const Text(
          "Transaksi Outlet",

          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: provider.loading
          ? _loadingState()
          : Column(
              children: [
                _searchBox(provider),

                _filterStatus(provider),

                _summary(provider),

                Expanded(
                  child: provider.orders.isEmpty
                      ? _emptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.all(14),

                          itemCount: provider.orders.length,

                          itemBuilder: (context, index) {
                            final order = provider.orders[index];

                            return _OrderCard(order: order);
                          },
                        ),
                ),

                if (provider.orders.isNotEmpty) _pagination(provider),
              ],
            ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryRed,

        foregroundColor: Colors.white,

        icon: const Icon(Icons.add),

        label: const Text("Tambah"),

        onPressed: () {
          Navigator.push(
            context,

            MaterialPageRoute(builder: (_) => const FormOrderScreen()),
          ).then((_) {
            context.read<OrderProvider>().fetchOrders();
          });
        },
      ),
    );
  }

  Widget _loadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          CircularProgressIndicator(color: primaryRed),

          SizedBox(height: 15),

          Text(
            "Mengambil data transaksi...",

            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(Icons.inbox_outlined, size: 60, color: Colors.grey),

          SizedBox(height: 15),

          Text(
            "Belum ada transaksi",

            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 5),

          Text(
            "Tambahkan transaksi baru",

            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _searchBox(OrderProvider provider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),

      child: TextField(
        onChanged: provider.searchOrder,

        decoration: InputDecoration(
          hintText: "Cari kode atau pelanggan...",

          prefixIcon: const Icon(Icons.search),

          filled: true,

          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),

            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _filterStatus(OrderProvider provider) {
    final statusList = ["Semua", "Diterima", "Diproses", "Selesai"];

    return SizedBox(
      height: 45,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        padding: const EdgeInsets.symmetric(horizontal: 14),

        itemCount: statusList.length,

        itemBuilder: (context, index) {
          final status = statusList[index];

          final selected = provider.selectedStatus == status;

          return Padding(
            padding: const EdgeInsets.only(right: 8),

            child: ChoiceChip(
              label: Text(status),

              selected: selected,

              selectedColor: primaryRed,

              labelStyle: TextStyle(
                color: selected ? Colors.white : Colors.black,
              ),

              onSelected: (_) {
                provider.filterStatus(status);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _summary(OrderProvider provider) {
    return Container(
      margin: const EdgeInsets.all(14),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          _summaryItem("Total", provider.totalOrder),

          _summaryItem("Proses", provider.totalDiproses),

          _summaryItem("Selesai", provider.totalSelesai),
        ],
      ),
    );
  }

  Widget _summaryItem(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),

          style: const TextStyle(
            color: primaryRed,

            fontSize: 20,

            fontWeight: FontWeight.bold,
          ),
        ),

        Text(title, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _pagination(OrderProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          IconButton(
            onPressed: provider.currentPage > 1 ? provider.previousPage : null,

            icon: const Icon(Icons.chevron_left),
          ),

          Text(
            "${provider.currentPage}/${provider.totalPages}",

            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          IconButton(
            onPressed: provider.currentPage < provider.totalPages
                ? provider.nextPage
                : null,

            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}

// ===============================
// CARD TRANSAKSI
// ===============================

class _OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const _OrderCard({required this.order});

  static const Color primaryRed = Color(0xffd50000);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

      child: ListTile(
        onTap: () {
          Navigator.push(
            context,

            MaterialPageRoute(builder: (_) => DetailOrderScreen(order: order)),
          );
        },

        leading: CircleAvatar(
          backgroundColor: Colors.red.shade50,

          child: const Icon(Icons.receipt_long, color: primaryRed),
        ),

        title: Text(
          order["code"] ?? "-",

          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Text(
          "${order["customer"] ?? "-"}\n${order["service"] ?? "-"}",
        ),

        trailing: Text(
          "Rp ${order["price"] ?? 0}",

          style: const TextStyle(
            color: primaryRed,

            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
