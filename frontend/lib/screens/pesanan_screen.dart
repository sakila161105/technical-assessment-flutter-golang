import 'package:flutter/material.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({super.key});

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  static const Color primaryRed = Color(0xffd50000);

  final TextEditingController search = TextEditingController();

  List<Map<String, dynamic>> pesanan = [
    {
      "nama": "Budi",
      "layanan": "Cuci Setrika",
      "berat": 3,
      "harga": 30000,
      "status": "Proses",
    },

    {
      "nama": "Ani",
      "layanan": "Laundry Express",
      "berat": 5,
      "harga": 75000,
      "status": "Selesai",
    },
  ];

  List<Map<String, dynamic>> hasil = [];

  @override
  void initState() {
    super.initState();

    hasil = pesanan;
  }

  void cari(String value) {
    setState(() {
      hasil = pesanan.where((item) {
        return item["nama"].toString().toLowerCase().contains(
          value.toLowerCase(),
        );
      }).toList();
    });
  }

  void hapus(int index) {
    setState(() {
      pesanan.removeAt(index);

      hasil = pesanan;
    });
  }

  void tambah() {
    setState(() {
      pesanan.add({
        "nama": "Customer Baru",

        "layanan": "Cuci Kering",

        "berat": 2,

        "harga": 14000,

        "status": "Baru",
      });

      hasil = pesanan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),

      appBar: AppBar(
        title: const Text("Pesanan Laundry"),

        backgroundColor: primaryRed,

        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),

            child: TextField(
              onChanged: cari,

              decoration: InputDecoration(
                hintText: "Cari pelanggan...",

                prefixIcon: const Icon(Icons.search),

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),

                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: hasil.length,

              itemBuilder: (context, index) {
                final item = hasil[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,

                    vertical: 6,
                  ),

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red.shade100,

                      child: const Icon(
                        Icons.local_laundry_service,

                        color: primaryRed,
                      ),
                    ),

                    title: Text(
                      item["nama"],

                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text("${item["layanan"]}\n${item["status"]}"),

                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),

                      onPressed: () {
                        hapus(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryRed,

        foregroundColor: Colors.white,

        child: const Icon(Icons.add),

        onPressed: tambah,
      ),
    );
  }
}
