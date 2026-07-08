import 'package:flutter/material.dart';

class PrinterScreen extends StatefulWidget {
  const PrinterScreen({super.key});

  @override
  State<PrinterScreen> createState() => _PrinterScreenState();
}


class _PrinterScreenState extends State<PrinterScreen> {

  bool printerAktif = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(

        title: const Text(
          "Printer & Nota",
        ),

        backgroundColor: Colors.red,

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

                borderRadius:
                BorderRadius.circular(18),

              ),


              child: Column(

                children: [


                  const Icon(

                    Icons.print,

                    size:80,

                    color:Colors.green,

                  ),


                  const SizedBox(height:20),


                  const Text(

                    "Pengaturan Printer",

                    style:TextStyle(

                      fontSize:22,

                      fontWeight:FontWeight.bold,

                    ),

                  ),


                  const SizedBox(height:20),



                  SwitchListTile(

                    title:
                    const Text(
                      "Aktifkan Printer",
                    ),

                    subtitle:
                    Text(

                      printerAktif
                      ? "Printer terhubung"
                      : "Printer belum terhubung",

                    ),


                    value:
                    printerAktif,


                    onChanged:(value){

                      setState((){

                        printerAktif=value;

                      });

                    },


                  ),



                  const Divider(),



                  ListTile(

                    leading:
                    const Icon(
                      Icons.receipt_long,
                      color:Colors.orange,
                    ),


                    title:
                    const Text(
                      "Ukuran Nota",
                    ),


                    subtitle:
                    const Text(
                      "58 mm",
                    ),

                  ),



                  ListTile(

                    leading:
                    const Icon(
                      Icons.settings,
                      color:Colors.blue,
                    ),


                    title:
                    const Text(
                      "Cetak Otomatis",
                    ),


                    subtitle:
                    const Text(
                      "Nonaktif",
                    ),

                  ),



                ],

              ),

            ),


            const SizedBox(height:25),


            SizedBox(

              width:
              double.infinity,


              child:
              ElevatedButton(

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  Colors.red,

                  foregroundColor:
                  Colors.white,

                ),


                onPressed:(){

                  ScaffoldMessenger.of(context)
                  .showSnackBar(

                    const SnackBar(

                      content:
                      Text(
                        "Pengaturan printer disimpan",
                      ),

                    ),

                  );

                },


                child:
                const Text(
                  "Simpan Pengaturan",
                ),

              ),

            )

          ],

        ),

      ),

    );

  }

}