import 'package:flutter/material.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  static const Color primaryRed = Color(0xffd50000);

  final TextEditingController nominalController = TextEditingController();

  String metode = "";

  final List<Map<String, String>> bank = [
    {"nama": "BCA", "asset": "assets/icons/bca.png"},

    {"nama": "BNI", "asset": "assets/icons/bni.png"},

    {"nama": "BRI", "asset": "assets/icons/bri.png"},

    {"nama": "BSI", "asset": "assets/icons/bsi.png"},

    {"nama": "CIMB", "asset": "assets/icons/cimb.png"},

    {"nama": "Mandiri", "asset": "assets/icons/mandiri.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),

      appBar: AppBar(
        title: const Text("Top Up Saldo"),

        backgroundColor: primaryRed,

        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Pilih Metode Pembayaran",

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            GridView.builder(
              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),

              itemCount: bank.length,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,

                childAspectRatio: 1,

                crossAxisSpacing: 12,

                mainAxisSpacing: 12,
              ),

              itemBuilder: (context, index) {
                final item = bank[index];

                bool aktif = metode == item["nama"];

                return InkWell(
                  onTap: () {
                    setState(() {
                      metode = item["nama"]!;
                    });
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(18),

                      border: Border.all(
                        color: aktif ? primaryRed : Colors.transparent,

                        width: 2,
                      ),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.account_balance,

                          size: 35,

                          color: aktif ? primaryRed : Colors.grey,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          item["nama"]!,

                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            const Text(
              "Nominal Top Up",

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: nominalController,

              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                hintText: "Contoh: 100000",

                prefixText: "Rp ",

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),

                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              height: 50,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,

                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),

                onPressed: () {
                  if (metode.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Pilih metode pembayaran")),
                    );

                    return;
                  }

                  if (nominalController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Masukkan nominal")),
                    );

                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Top Up $metode berhasil diproses")),
                  );
                },

                child: const Text(
                  "TOP UP SEKARANG",

                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
