import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../../theme/app_theme.dart';

class CategoryDetailScreen extends StatelessWidget {
  final GroceryCategory category;
  const CategoryDetailScreen({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.nameBn)),
      body: Center(
        child: Text('${category.nameBn} — ধাপ ৩ এ আসবে',
            style: AppTheme.body),
      ),
    );
  }
}
