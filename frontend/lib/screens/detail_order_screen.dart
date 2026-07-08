import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import 'form_order_screen.dart';

class DetailOrderScreen extends StatefulWidget {
  final Map<String, dynamic> order;

  const DetailOrderScreen({super.key, required this.order});

  @override
  State<DetailOrderScreen> createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  static const Color primaryRed = Color(0xffd50000);

  Map<String, dynamic>? detailOrder;

  bool loading = true;

  @override
  void initState() {
    super.initState();

    loadDetail();
  }

  Future<void> loadDetail() async {
    try {
      final provider = context.read<OrderProvider>();

      final data = await provider.getOrderDetail(widget.order["id"]);

      setState(() {
        detailOrder = data;

        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OrderProvider>();

    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final order = detailOrder ?? widget.order;

    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),

      appBar: AppBar(
        backgroundColor: primaryRed,

        foregroundColor: Colors.white,

        title: const Text(
          "Detail Transaksi",

          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: _cardDecoration(),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,

                        backgroundColor: primaryRed.withOpacity(.12),

                        child: const Icon(
                          Icons.receipt_long,

                          color: primaryRed,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              order["code"] ?? "-",

                              style: const TextStyle(
                                color: primaryRed,

                                fontSize: 18,

                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Text(
                              "Transaksi Laundry",

                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      _statusBadge(order["status"] ?? ""),
                    ],
                  ),

                  const Divider(height: 30),

                  _detailRow("Pelanggan", order["customer"]),

                  _detailRow("Layanan", order["service"]),

                  _detailRow("Jumlah Layanan", order["serviceCount"]),

                  _detailRow("Tanggal Masuk", order["date"]),

                  _detailRow("Estimasi", order["estimate"]),

                  _detailRow("Status", order["status"]),

                  _detailRow("Pembayaran", order["payment"]),

                  _detailRow("Total Harga", "Rp ${order["price"]}"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(16),

              decoration: _cardDecoration(),

              child: Text(
                order["payment"] == "Lunas"
                    ? "Catatan: Pesanan sudah lunas."
                    : "Catatan: Pembayaran belum lunas.",

                style: const TextStyle(color: Colors.black54, height: 1.5),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.edit),

                    label: const Text("Edit"),

                    onPressed: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) => FormOrderScreen(order: order),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.delete),

                    label: const Text("Hapus"),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed,

                      foregroundColor: Colors.white,
                    ),

                    onPressed: () {
                      _confirmDelete(context, provider, order["id"]);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,

    OrderProvider provider,

    int id,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Transaksi"),

          content: const Text("Yakin ingin menghapus transaksi ini?"),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),

              child: const Text("Batal"),
            ),

            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),

              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      final success = await provider.deleteOrder(id);

      if (context.mounted) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? "Berhasil dihapus" : "Gagal menghapus"),
          ),
        );
      }
    }
  }

  Widget _detailRow(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(
            width: 130,

            child: Text(title, style: const TextStyle(color: Colors.grey)),
          ),

          Expanded(
            child: Text(
              value?.toString() ?? "-",

              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color color = Colors.grey;

    if (status == "Diterima") {
      color = Colors.blue;
    }

    if (status == "Diproses") {
      color = Colors.orange;
    }

    if (status == "Selesai") {
      color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

      decoration: BoxDecoration(
        color: color.withOpacity(.15),

        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        status,

        style: TextStyle(
          color: color,

          fontWeight: FontWeight.bold,

          fontSize: 11,
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,

      borderRadius: BorderRadius.circular(18),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.08),

          blurRadius: 10,

          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
