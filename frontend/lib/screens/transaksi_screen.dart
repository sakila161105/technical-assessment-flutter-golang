import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import 'form_order_screen.dart';
import 'detail_order_screen.dart';


class TransaksiScreen extends StatefulWidget {

  const TransaksiScreen({super.key});


  @override
  State<TransaksiScreen> createState() =>
      _TransaksiScreenState();

}



class _TransaksiScreenState extends State<TransaksiScreen> {


  static const Color primaryRed =
  Color(0xffd50000);



  @override
  void initState(){

    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      context
          .read<OrderProvider>()
          .fetchOrders();

    });

  }





  @override
  Widget build(BuildContext context){


    final provider =
    context.watch<OrderProvider>();



    return Scaffold(


      backgroundColor:
      const Color(0xfff3f3f3),



      appBar:

      AppBar(

        backgroundColor:
        primaryRed,


        foregroundColor:
        Colors.white,


        title:

        const Text(

          "Transaksi Outlet",

          style:

          TextStyle(

            fontWeight:
            FontWeight.bold,

          ),

        ),


      ),





      body:

      provider.loading

      ?

      const Center(

        child:

        CircularProgressIndicator(

          color:
          primaryRed,

        ),

      )

      :

      SingleChildScrollView(


        child:

        Column(

          children: [



            _search(provider),



            _filter(provider),




            _summary(provider),






            provider.orders.isEmpty


                ?


            _empty()



                :



            ListView.builder(


              shrinkWrap:
              true,


              physics:

              const NeverScrollableScrollPhysics(),



              padding:

              const EdgeInsets.symmetric(
                  horizontal:14
              ),



              itemCount:

              provider.orders.length,



              itemBuilder:
                  (context,index){


                return OrderCard(

                    order:
                    provider.orders[index]

                );


              },


            ),





            _pagination(provider),



            const SizedBox(
              height:100,
            ),



          ],


        ),


      ),





      floatingActionButton:

      FloatingActionButton.extended(



        backgroundColor:
        primaryRed,


        foregroundColor:
        Colors.white,



        icon:

        const Icon(
          Icons.add,
        ),



        label:

        const Text(
          "Tambah",
        ),




        onPressed: () async{


          await Navigator.push(

              context,


              MaterialPageRoute(

                  builder:(_)=>

                  const FormOrderScreen()

              )

          );



          provider.fetchOrders();



        },


      ),


    );

  }







  Widget _search(OrderProvider provider){


    return Padding(

      padding:

      const EdgeInsets.all(12),



      child:

      TextField(


        onChanged:

        provider.searchOrder,



        decoration:

        InputDecoration(


          hintText:

          "Cari kode atau pelanggan...",



          prefixIcon:

          const Icon(
              Icons.search
          ),



          filled:

          true,



          fillColor:

          Colors.white,



          border:

          OutlineInputBorder(

            borderRadius:

            BorderRadius.circular(15),


            borderSide:

            BorderSide.none,

          ),


        ),


      ),


    );


  }







  Widget _filter(OrderProvider provider){


    final status=[

      "Semua",

      "Diterima",

      "Diproses",

      "Selesai",

    ];



    return SizedBox(


      height:

      40,



      child:

      ListView(

        scrollDirection:

        Axis.horizontal,



        padding:

        const EdgeInsets.symmetric(
            horizontal:12
        ),



        children: [



          ...status.map((item){



            final selected =

            provider.selectedStatus ==
                item;




            return Padding(

              padding:

              const EdgeInsets.only(
                  right:6
              ),



              child:

              ChoiceChip(

                label:

                Text(

                  item,

                  style:

                  const TextStyle(
                    fontSize:12,
                  ),

                ),



                selected:

                selected,



                selectedColor:

                primaryRed,



                labelStyle:

                TextStyle(

                  color:

                  selected

                      ?

                  Colors.white

                      :

                  Colors.black,

                ),



                onSelected:(_){

                  provider.filterStatus(
                      item
                  );

                },


              ),


            );


          }),




          ActionChip(

            avatar:

            const Icon(

              Icons.calendar_month,

              size:16,

            ),



            label:

            Text(

              provider.startDate == null

                  ?

              "Tanggal"

                  :

              "${provider.startDate!.day}/"
                  "${provider.startDate!.month}",



              style:

              const TextStyle(
                  fontSize:12
              ),

            ),



            onPressed:() async{


              final date =

              await showDatePicker(

                context:
                context,


                initialDate:
                DateTime.now(),


                firstDate:
                DateTime(2024),


                lastDate:
                DateTime(2030),


              );



              if(date != null){


                provider.filterDate(
                    date,
                    date
                );


              }


            },


          ),


        ],


      ),


    );


  }







  Widget _summary(OrderProvider provider){


    return Container(


      margin:

      const EdgeInsets.all(12),



      padding:

      const EdgeInsets.all(15),



      decoration:

      BoxDecoration(

        color:

        Colors.white,


        borderRadius:

        BorderRadius.circular(18),

      ),



      child:

      Row(

        mainAxisAlignment:

        MainAxisAlignment.spaceAround,


        children: [


          _item(
              "Total",
              provider.totalOrder
          ),


          _item(
              "Proses",
              provider.totalDiproses
          ),


          _item(
              "Selesai",
              provider.totalSelesai
          ),


        ],

      ),


    );


  }





  Widget _item(String title,int value){


    return Column(

      children:[


        Text(

          "$value",

          style:

          const TextStyle(

            color:
            primaryRed,


            fontWeight:
            FontWeight.bold,


            fontSize:
            20,

          ),

        ),



        Text(title),


      ],

    );


  }






  Widget _empty(){


    return const Padding(

      padding:
      EdgeInsets.all(40),


      child:

      Text(
        "Belum ada transaksi",
      ),

    );


  }







  Widget _pagination(OrderProvider provider){


    return Row(

      mainAxisAlignment:

      MainAxisAlignment.center,


      children: [


        IconButton(

          onPressed:

          provider.currentPage > 1

              ?

          provider.previousPage

              :

          null,


          icon:

          const Icon(
              Icons.chevron_left
          ),

        ),



        Text(

          "${provider.currentPage}/${provider.totalPages}",

        ),



        IconButton(

          onPressed:

          provider.currentPage <
              provider.totalPages

              ?

          provider.nextPage

              :

          null,


          icon:

          const Icon(
              Icons.chevron_right
          ),

        ),


      ],

    );


  }

}






class OrderCard extends StatelessWidget {


  final Map<String,dynamic> order;


  const OrderCard({

    super.key,

    required this.order,

  });




  @override
  Widget build(BuildContext context){


    return Card(

      margin:

      const EdgeInsets.only(
          bottom:12
      ),


      child:

      ListTile(


        onTap:(){


          Navigator.push(

              context,

              MaterialPageRoute(

                  builder:(_)=>

                  DetailOrderScreen(

                      order:order

                  )

              )

          );


        },



        leading:

        const Icon(
            Icons.receipt_long,
            color:Colors.red
        ),



        title:

        Text(
            order["customer"] ?? "-"
        ),



        subtitle:

        Text(

          "${order["service"] ?? "-"}\n"
              "${order["date"] ?? "-"}",

        ),



        trailing:

        Text(

          "Rp ${order["price"] ?? 0}",

          style:

          const TextStyle(

              color:Colors.red,

              fontWeight:
              FontWeight.bold

          ),

        ),


      ),

    );


  }


}