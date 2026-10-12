import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('কার্ট')),
      body: Center(
        child: Text('কার্ট স্ক্রিন — ধাপ ৪ এ আসবে',
            style: AppTheme.body),
      ),
    );
  }
}
