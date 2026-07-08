import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}


class _PasswordScreenState extends State<PasswordScreen> {

  final oldPasswordController =
      TextEditingController();

  final newPasswordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();


  bool hideOld = true;
  bool hideNew = true;
  bool hideConfirm = true;



  void simpanPassword(){

    if(newPasswordController.text != 
       confirmPasswordController.text){

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Password baru tidak sama",
          ),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Password berhasil diperbarui",
        ),
        backgroundColor: Colors.green,
      ),
    );

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF5F5F5),


      appBar: AppBar(

        title:
        const Text(
          "Ganti Password",
        ),

        backgroundColor:
        Colors.red,

        foregroundColor:
        Colors.white,

      ),



      body:
      Padding(

        padding:
        const EdgeInsets.all(20),


        child:
        Column(

          children:[


            Container(

              padding:
              const EdgeInsets.all(20),


              decoration:
              BoxDecoration(

                color:
                Colors.white,

                borderRadius:
                BorderRadius.circular(20),

              ),



              child:
              Column(

                children:[


                  const Icon(

                    Icons.lock_outline,

                    size:70,

                    color:Colors.red,

                  ),


                  const SizedBox(height:20),



                  _passwordField(

                    "Password Lama",

                    oldPasswordController,

                    hideOld,

                    (){

                      setState((){

                        hideOld=!hideOld;

                      });

                    },

                  ),



                  _passwordField(

                    "Password Baru",

                    newPasswordController,

                    hideNew,

                    (){

                      setState((){

                        hideNew=!hideNew;

                      });

                    },

                  ),




                  _passwordField(

                    "Konfirmasi Password",

                    confirmPasswordController,

                    hideConfirm,

                    (){

                      setState((){

                        hideConfirm=!hideConfirm;

                      });

                    },

                  ),



                ],

              ),

            ),



            const SizedBox(height:25),



            SizedBox(

              width:
              double.infinity,


              height:
              50,


              child:
              ElevatedButton(

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  Colors.red,

                  foregroundColor:
                  Colors.white,

                  shape:
                  RoundedRectangleBorder(

                    borderRadius:
                    BorderRadius.circular(20),

                  ),

                ),


                onPressed:
                simpanPassword,


                child:
                const Text(

                  "Simpan Password",

                  style:
                  TextStyle(

                    fontWeight:
                    FontWeight.bold,

                  ),

                ),

              ),

            )

          ],

        ),

      ),

    );

  }





  Widget _passwordField(

    String label,

    TextEditingController controller,

    bool hide,

    VoidCallback action,

  ){

    return Padding(

      padding:
      const EdgeInsets.only(
        bottom:15,
      ),


      child:
      TextField(

        controller:
        controller,


        obscureText:
        hide,


        decoration:
        InputDecoration(

          labelText:
          label,


          filled:
          true,


          fillColor:
          Colors.grey.shade100,


          border:
          OutlineInputBorder(

            borderRadius:
            BorderRadius.circular(14),

            borderSide:
            BorderSide.none,

          ),


          suffixIcon:
          IconButton(

            icon:
            Icon(

              hide
              ? Icons.visibility_off
              : Icons.visibility,

            ),


            onPressed:
            action,

          ),

        ),

      ),

    );

  }

}