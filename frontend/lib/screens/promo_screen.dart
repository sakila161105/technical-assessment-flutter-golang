import 'package:flutter/material.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  static const Color primaryRed = Color(0xffd50000);

  @override
  Widget build(BuildContext context) {
    final promo = [
      {
        "judul": "Diskon Cuci Setrika",
        "isi": "Diskon 20% untuk pelanggan baru",
        "icon": Icons.local_offer,
      },

      {
        "judul": "Paket Bulanan Hemat",
        "isi": "Laundry unlimited lebih murah",
        "icon": Icons.calendar_month,
      },

      {
        "judul": "Promo Member",
        "isi": "Dapatkan poin setiap transaksi",
        "icon": Icons.card_giftcard,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),

      appBar: AppBar(
        title: const Text("Promo Laundry"),

        backgroundColor: primaryRed,

        foregroundColor: Colors.white,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(18),

        itemCount: promo.length,

        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),

            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(20),
            ),

            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,

                  backgroundColor: Colors.red.shade50,

                  child: Icon(
                    promo[index]["icon"] as IconData,

                    color: primaryRed,

                    size: 30,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        promo[index]["judul"] as String,

                        style: const TextStyle(
                          fontSize: 17,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        promo[index]["isi"] as String,

                        style: const TextStyle(color: Colors.black54),
                      ),

                      const SizedBox(height: 10),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryRed,

                          foregroundColor: Colors.white,
                        ),

                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Promo berhasil dipilih"),
                            ),
                          );
                        },

                        child: const Text("Gunakan Promo"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
