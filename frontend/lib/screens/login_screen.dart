import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_nav.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool hidePassword = true;

  bool rememberMe = false;

  static const Color primaryRed = Color(0xffd50000);

  void login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final auth = context.read<AuthProvider>();

    final result = await auth.login(
      emailController.text.trim(),

      passwordController.text.trim(),
    );

    if (result) {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const BottomNav()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email atau password salah")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: const Color(0xfffafafa),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),

            child: Form(
              key: formKey,

              child: Column(
                children: [
                  // LOGO AYOCUCI
                  Image.asset(
                    "assets/icons/logo/logo_login_screen.webp",

                    width: 240,

                    height: 150,

                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Selamat Datang",

                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Silahkan login untuk masuk ke aplikasi",

                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 35),

                  TextFormField(
                    controller: emailController,

                    keyboardType: TextInputType.emailAddress,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email wajib diisi";
                      }

                      if (!value.contains("@")) {
                        return "Email tidak valid";
                      }

                      return null;
                    },

                    decoration: InputDecoration(
                      hintText: "Email",

                      prefixIcon: const Icon(Icons.email_outlined),

                      filled: true,

                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: passwordController,

                    obscureText: hidePassword,

                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password minimal 6 karakter";
                      }

                      return null;
                    },

                    decoration: InputDecoration(
                      hintText: "Password",

                      prefixIcon: const Icon(Icons.lock_outline),

                      suffixIcon: IconButton(
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),

                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),

                      filled: true,

                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,

                            activeColor: primaryRed,

                            onChanged: (value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            },
                          ),

                          const Text(
                            "Ingat saya",

                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),

                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Lupa password belum tersedia"),
                            ),
                          );
                        },

                        child: const Text(
                          "Lupa password?",

                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,

                    height: 52,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRed,

                        foregroundColor: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),

                      onPressed: auth.loading ? null : login,

                      child: auth.loading
                          ? const SizedBox(
                              width: 22,

                              height: 22,

                              child: CircularProgressIndicator(
                                color: Colors.white,

                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "LOGIN",

                              style: TextStyle(
                                fontSize: 18,

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
