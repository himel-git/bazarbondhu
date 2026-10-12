import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

/// BazarBondhu (বাজারবন্ধু) — বাংলাদেশের বাজারদর ও দাম তুলনার অ্যাপ।
///
/// প্রাথমিক বাজার: কারওয়ান বাজার, ঢাকা।
/// সব দাম এই মুহূর্তে ডেমো — বাস্তব নয়।
void main() {
  runApp(const BazarBondhuApp());
}

class BazarBondhuApp extends StatelessWidget {
  const BazarBondhuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'বাজারবন্ধু',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const HomeScreen(),
    );
  }
}
