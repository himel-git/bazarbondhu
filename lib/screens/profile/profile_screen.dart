import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('প্রোফাইল')),
      body: Center(
        child: Text('প্রোফাইল — ধাপ ৫ এ আসবে',
            style: AppTheme.body),
      ),
    );
  }
}
