import 'package:flutter/material.dart';

class LayananScreen extends StatelessWidget {
  const LayananScreen({super.key});

  static const Color primaryRed = Color(0xffd50000);

  @override
  Widget build(BuildContext context) {
    final layanan = [
      {
        "nama": "Cuci Kering",
        "harga": "Rp 7.000 / kg",
        "icon": Icons.local_laundry_service,
      },

      {"nama": "Cuci Setrika", "harga": "Rp 10.000 / kg", "icon": Icons.iron},

      {
        "nama": "Laundry Express",
        "harga": "Rp 15.000 / kg",
        "icon": Icons.flash_on,
      },

      {"nama": "Cuci Sepatu", "harga": "Rp 25.000", "icon": Icons.shopping_bag},

      {
        "nama": "Cuci Karpet",
        "harga": "Mulai Rp 50.000",
        "icon": Icons.cleaning_services,
      },

      {
        "nama": "Paket Bulanan",
        "harga": "Harga khusus pelanggan",
        "icon": Icons.card_membership,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),

      appBar: AppBar(
        title: const Text("Layanan Laundry"),

        backgroundColor: primaryRed,

        foregroundColor: Colors.white,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(18),

        itemCount: layanan.length,

        itemBuilder: (context, index) {
          final item = layanan[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 15),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(18),

              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 8),
              ],
            ),

            child: ListTile(
              leading: CircleAvatar(
                radius: 28,

                backgroundColor: Colors.red.shade50,

                child: Icon(item["icon"] as IconData, color: primaryRed),
              ),

              title: Text(
                item["nama"] as String,

                style: const TextStyle(
                  fontWeight: FontWeight.bold,

                  fontSize: 17,
                ),
              ),

              subtitle: Text(item["harga"] as String),

              trailing: const Icon(Icons.chevron_right),

              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${item["nama"]} dipilih")),
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryRed,

        foregroundColor: Colors.white,

        child: const Icon(Icons.add),

        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Tambah layanan baru")));
        },
      ),
    );
  }
}
