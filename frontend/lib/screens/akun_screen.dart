import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../providers/account_provider.dart';

import 'profil_screen.dart';
import 'printer_screen.dart';
import 'password_screen.dart';
import 'ulasan_screen.dart';
import 'syarat_screen.dart';
import 'privasi_screen.dart';
import 'tentang_screen.dart';

class AkunScreen extends StatelessWidget {
  const AkunScreen({super.key});

  static const Color primaryRed = Color(0xffd50000);

  @override
  Widget build(BuildContext context) {
    final account = context.watch<AccountProvider>();

    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),

      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,

          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),

              decoration: const BoxDecoration(
                color: primaryRed,

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),

                  bottomRight: Radius.circular(30),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          account.ownerName,

                          style: const TextStyle(
                            color: Colors.white,

                            fontSize: 22,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,

                          vertical: 5,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.amber,

                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Text(
                          account.role,

                          style: const TextStyle(
                            color: Colors.white,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(
                        Icons.storefront,

                        color: Colors.white,

                        size: 32,
                      ),

                      const SizedBox(width: 10),

                      Text(
                        account.outletName,

                        style: const TextStyle(
                          color: Colors.white,

                          fontSize: 20,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: _topCard(
                          Icons.history,

                          "Membership",

                          "0 Hari",

                          Colors.white,

                          Colors.black,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _topCard(
                          Icons.groups,

                          "NO PACKAGE YET",

                          "",

                          Colors.grey,

                          Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(22),
              ),

              child: Column(
                children: [
                  _menu(context, Icons.person, "Profil Saya", Colors.blue),

                  _menu(context, Icons.print, "Printer & Nota", Colors.green),

                  _menu(context, Icons.lock, "Ganti Password", Colors.orange),

                  _menu(
                    context,
                    Icons.star,
                    "Berikan Ulasan PlayStore",
                    Colors.pink,
                  ),

                  _menu(
                    context,
                    Icons.description,
                    "Syarat dan Ketentuan",
                    Colors.teal,
                  ),

                  _menu(
                    context,
                    Icons.security,
                    "Kebijakan Privasi",
                    Colors.purple,
                  ),

                  _menu(context, Icons.info, "Tentang Kami", Colors.deepOrange),

                  _menu(
                    context,
                    Icons.share,
                    "Bagikan Aplikasi",
                    Colors.blue,
                    last: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),

              child: SizedBox(
                width: double.infinity,

                height: 50,

                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout),

                  label: const Text(
                    "KELUAR",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryRed,

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),

                  onPressed: () {
                    _logout(context);
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _topCard(
    IconData icon,
    String title,
    String value,
    Color bg,
    Color textColor,
  ) {
    return Container(
      height: 75,

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: bg,

        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          Icon(icon, color: textColor),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              "$title\n$value",

              style: TextStyle(
                color: textColor,

                fontSize: 12,

                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menu(
    BuildContext context,
    IconData icon,
    String title,
    Color color, {
    bool last = false,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: color, size: 30),

          title: Text(title, style: const TextStyle(fontSize: 16)),

          trailing: const Icon(Icons.chevron_right),

          onTap: () {
            if (title == "Profil Saya") {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const ProfilScreen()),
              );
            } else if (title == "Printer & Nota") {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const PrinterScreen()),
              );
            } else if (title == "Ganti Password") {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const PasswordScreen()),
              );
            } else if (title == "Berikan Ulasan PlayStore") {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const UlasanScreen()),
              );
            } else if (title == "Syarat dan Ketentuan") {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const SyaratScreen()),
              );
            } else if (title == "Kebijakan Privasi") {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const PrivasiScreen()),
              );
            } else if (title == "Tentang Kami") {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const TentangScreen()),
              );
            } else if (title == "Bagikan Aplikasi") {
              Share.share(
                "Download aplikasi Mewing Laundry untuk mengelola usaha laundry lebih mudah.",

                subject: "Mewing Laundry",
              );
            }
          },
        ),

        if (!last) Divider(height: 1, color: Colors.grey.shade200),
      ],
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          title: const Text("Keluar"),

          content: const Text("Yakin ingin keluar aplikasi?"),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Batal"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Keluar"),
            ),
          ],
        );
      },
    );
  }
}
