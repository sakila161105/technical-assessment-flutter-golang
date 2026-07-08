import 'package:flutter/material.dart';

class PelangganScreen extends StatefulWidget {
  const PelangganScreen({super.key});

  @override
  State<PelangganScreen> createState() => _PelangganScreenState();
}

class _PelangganScreenState extends State<PelangganScreen> {
  static const Color primaryRed = Color(0xffd50000);

  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> pelanggan = [
    {
      "nama": "Bunda Ana",
      "hp": "08123456789",
      "order": 12,
      "alamat": "Jl. Melati",
    },

    {"nama": "Andi", "hp": "08234567890", "order": 5, "alamat": "Jl. Mawar"},

    {"nama": "Rina", "hp": "08567890123", "order": 8, "alamat": "Jl. Kenanga"},
  ];

  List<Map<String, dynamic>> hasil = [];

  @override
  void initState() {
    super.initState();

    hasil = pelanggan;
  }

  void cari(String value) {
    setState(() {
      hasil = pelanggan.where((item) {
        return item["nama"].toString().toLowerCase().contains(
          value.toLowerCase(),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),

      appBar: AppBar(
        title: const Text("Pelanggan"),

        backgroundColor: primaryRed,

        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),

            child: TextField(
              controller: searchController,

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
              padding: const EdgeInsets.symmetric(horizontal: 15),

              itemCount: hasil.length,

              itemBuilder: (context, index) {
                final item = hasil[index];

                return Card(
                  elevation: 2,

                  margin: const EdgeInsets.only(bottom: 12),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red.shade100,

                      child: const Icon(Icons.person, color: primaryRed),
                    ),

                    title: Text(
                      item["nama"],

                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text("${item["hp"]}\n${item["alamat"]}"),

                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const Text("Order"),

                        Text(
                          "${item["order"]}",

                          style: const TextStyle(
                            color: primaryRed,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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

        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Tambah pelanggan baru")),
          );
        },
      ),
    );
  }
}
