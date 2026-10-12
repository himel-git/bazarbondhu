import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../theme/app_theme.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.nameBn)),
      body: Center(
        child: Text('${product.nameBn} — ধাপ ৩ এ আসবে',
            style: AppTheme.body),
      ),
    );
  }
}
