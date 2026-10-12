import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('শপিং তালিকা')),
      body: Center(
        child: Text('শপিং তালিকা — ধাপ ৪ এ আসবে',
            style: AppTheme.body),
      ),
    );
  }
}
