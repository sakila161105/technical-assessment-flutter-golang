import 'package:flutter/material.dart';

class PrivasiScreen extends StatelessWidget {
  const PrivasiScreen({super.key});

  static const Color primaryRed = Color(0xFFD50000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),

      appBar: AppBar(
        title: const Text(
          "Kebijakan Privasi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        backgroundColor: primaryRed,

        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Container(
          padding: const EdgeInsets.all(22),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(22),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Center(child: Icon(Icons.security, size: 75, color: primaryRed)),

              const SizedBox(height: 20),

              const Text(
                "Kebijakan Privasi",

                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              _item(
                "1. Pengumpulan Data",
                "Aplikasi dapat mengumpulkan data pengguna seperti nama, email, nomor telepon, dan informasi outlet untuk kebutuhan layanan.",
              ),

              _item(
                "2. Penggunaan Data",
                "Data digunakan untuk membantu proses pengelolaan laundry, transaksi, dan meningkatkan kualitas layanan aplikasi.",
              ),

              _item(
                "3. Keamanan Data",
                "Kami berusaha menjaga keamanan data pengguna dan mencegah akses yang tidak memiliki izin.",
              ),

              _item(
                "4. Penyimpanan Informasi",
                "Informasi pengguna dapat disimpan pada sistem aplikasi untuk kebutuhan operasional.",
              ),

              _item(
                "5. Perubahan Kebijakan",
                "Kebijakan privasi dapat diperbarui sesuai perkembangan fitur dan kebutuhan aplikasi.",
              ),

              const SizedBox(height: 20),

              const Divider(),

              const Text(
                "Versi Aplikasi 1.0.0",

                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(String title, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,

            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),

          Text(text, style: const TextStyle(fontSize: 15, height: 1.5)),
        ],
      ),
    );
  }
}
