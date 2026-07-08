import 'package:flutter/material.dart';

class UlasanScreen extends StatefulWidget {
  const UlasanScreen({super.key});

  @override
  State<UlasanScreen> createState() => _UlasanScreenState();
}

class _UlasanScreenState extends State<UlasanScreen> {
  int rating = 0;

  final TextEditingController komentarController = TextEditingController();

  void kirimUlasan() {
    if (rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Silahkan pilih rating bintang"),

          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Terima kasih atas ulasannya"),

        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text("Berikan Ulasan"),

        backgroundColor: const Color(0xFFD50000),

        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [
                  const Icon(
                    Icons.rate_review,

                    size: 70,

                    color: Color(0xFFD50000),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Bagaimana pengalaman Anda?",

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            rating = index + 1;
                          });
                        },

                        icon: Icon(
                          index < rating ? Icons.star : Icons.star_border,

                          color: Colors.amber,

                          size: 40,
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: komentarController,

                    maxLines: 4,

                    decoration: InputDecoration(
                      hintText: "Tulis komentar...",

                      filled: true,

                      fillColor: Colors.grey.shade100,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              height: 50,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD50000),

                  foregroundColor: Colors.white,
                ),

                onPressed: kirimUlasan,

                child: const Text(
                  "Kirim Ulasan",

                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
