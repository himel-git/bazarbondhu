import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('খুঁজুন')),
      body: Center(
        child: Text('সার্চ স্ক্রিন — ধাপ ৪ এ আসবে',
            style: AppTheme.body),
      ),
    );
  }
}
