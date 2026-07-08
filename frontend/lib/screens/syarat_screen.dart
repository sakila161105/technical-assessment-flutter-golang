import 'package:flutter/material.dart';

class SyaratScreen extends StatelessWidget {
  const SyaratScreen({super.key});

  static const Color primaryRed = Color(0xFFD50000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),

      appBar: AppBar(
        title: const Text(
          "Syarat dan Ketentuan",
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
              Center(
                child: Icon(Icons.description, size: 75, color: primaryRed),
              ),

              const SizedBox(height: 20),

              const Text(
                "Syarat dan Ketentuan",

                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              _text(
                "1. Pengguna wajib memberikan data yang benar dan lengkap saat menggunakan aplikasi.",
              ),

              _text(
                "2. Pengguna bertanggung jawab menjaga keamanan akun masing-masing.",
              ),

              _text(
                "3. Aplikasi digunakan untuk membantu pengelolaan usaha laundry.",
              ),

              _text(
                "4. Semua transaksi yang dilakukan melalui aplikasi menjadi tanggung jawab pengguna.",
              ),

              _text(
                "5. Pengguna tidak diperbolehkan menyalahgunakan layanan aplikasi.",
              ),

              _text(
                "6. Pengembang dapat melakukan perubahan fitur untuk meningkatkan kualitas layanan.",
              ),

              const SizedBox(height: 20),

              const Divider(),

              const SizedBox(height: 10),

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

  Widget _text(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Text(text, style: const TextStyle(fontSize: 16, height: 1.5)),
    );
  }
}
