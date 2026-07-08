import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/account_provider.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final account = context.watch<AccountProvider>();

    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),

      appBar: AppBar(
        title: const Text("Profil Saya"),

        backgroundColor: Colors.red,

        foregroundColor: Colors.white,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              CircleAvatar(
                radius: 45,

                backgroundColor: Colors.red.shade100,

                child: const Icon(Icons.person, size: 55, color: Colors.red),
              ),

              const SizedBox(height: 25),

              _item("Nama Owner", account.ownerName),

              _item("Nama Outlet", account.outletName),

              _item("Role", account.role),

              _item("Email", account.email),

              _item("Nomor HP", account.phone),

              _item("Alamat", account.address),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,

                height: 50,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),

                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Data berhasil disimpan")),
                    );
                  },

                  child: const Text(
                    "Simpan Perubahan",

                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(String title, String value) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(14),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),

            blurRadius: 5,

            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        children: [
          Expanded(
            flex: 2,

            child: Text(
              title,

              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),

          Expanded(
            flex: 3,

            child: Text(
              value,

              textAlign: TextAlign.right,

              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
