import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/dashboard_provider.dart';
import 'providers/order_provider.dart';
import 'providers/account_provider.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        ChangeNotifierProvider(create: (_) => DashboardProvider()),

        ChangeNotifierProvider(create: (_) => OrderProvider()),

        ChangeNotifierProvider(create: (_) => AccountProvider()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Technical Assessment',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),

        useMaterial3: true,
      ),

      home: const LoginScreen(),
    );
  }
}
