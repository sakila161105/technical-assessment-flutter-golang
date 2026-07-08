import 'package:flutter/material.dart';

class TentangScreen extends StatelessWidget {
  const TentangScreen({super.key});

  static const Color primaryRed = Color(0xFFD50000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),

      appBar: AppBar(
        title: const Text(
          "Tentang Kami",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        backgroundColor: primaryRed,

        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(22),
              ),

              child: Column(
                children: [
                  const Icon(
                    Icons.local_laundry_service,

                    size: 80,

                    color: primaryRed,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Mewing Laundry",

                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Aplikasi manajemen laundry yang membantu pemilik usaha mengelola order, status cucian, pelanggan, dan transaksi dengan lebih mudah.",

                    textAlign: TextAlign.center,

                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(22),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Informasi Aplikasi",

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  _item(Icons.apps, "Versi", "1.0.0"),

                  _item(Icons.business, "Developer", "Mewing Laundry Team"),

                  _item(Icons.email, "Email", "support@mewinglaundry.com"),
                ],
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              "Terima kasih telah menggunakan aplikasi kami.",

              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),

      child: Row(
        children: [
          Icon(icon, color: primaryRed),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
