import 'package:flutter/material.dart';

class PengeluaranScreen extends StatefulWidget {
  const PengeluaranScreen({super.key});

  @override
  State<PengeluaranScreen> createState() => _PengeluaranScreenState();
}

class _PengeluaranScreenState extends State<PengeluaranScreen> {
  static const Color primaryRed = Color(0xffd50000);

  final List<Map<String, dynamic>> data = [
    {
      "kategori": "Bahan Laundry",
      "keterangan": "Sabun dan pewangi",
      "tanggal": "08-07-2026",
      "jumlah": 50000,
    },

    {
      "kategori": "Operasional",
      "keterangan": "Listrik dan Air",
      "tanggal": "08-07-2026",
      "jumlah": 150000,
    },

    {
      "kategori": "Packaging",
      "keterangan": "Plastik laundry",
      "tanggal": "07-07-2026",
      "jumlah": 30000,
    },

    {
      "kategori": "Karyawan",
      "keterangan": "Gaji pegawai",
      "tanggal": "01-07-2026",
      "jumlah": 1000000,
    },
  ];

  String rupiah(int angka) {
    return "Rp ${angka.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => "${match[1]}.")}";
  }

  int total() {
    int hasil = 0;

    for (var item in data) {
      hasil += item["jumlah"] as int;
    }

    return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),

      appBar: AppBar(
        title: const Text("Pengeluaran Laundry"),

        backgroundColor: primaryRed,

        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),

            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: primaryRed,

              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  "Total Pengeluaran",

                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),

                const SizedBox(height: 8),

                Text(
                  rupiah(total()),

                  style: const TextStyle(
                    color: Colors.white,

                    fontSize: 25,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),

              itemCount: data.length,

              itemBuilder: (context, index) {
                final item = data[index];

                return Card(
                  elevation: 2,

                  margin: const EdgeInsets.only(bottom: 12),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red.shade100,

                      child: const Icon(Icons.money_off, color: primaryRed),
                    ),

                    title: Text(
                      item["kategori"],

                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text("${item["keterangan"]}\n${item["tanggal"]}"),

                    trailing: Text(
                      rupiah(item["jumlah"]),

                      style: const TextStyle(
                        color: primaryRed,

                        fontWeight: FontWeight.bold,
                      ),
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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Tambah pengeluaran")));
        },
      ),
    );
  }
}
