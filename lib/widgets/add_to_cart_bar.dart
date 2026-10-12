import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// নিচে sticky বাটন — "কার্টে যোগ করুন (৳xxx)"
class AddToCartBar extends StatelessWidget {
  final double totalPrice;
  final String label;
  final VoidCallback onPressed;
  final IconData icon;

  const AddToCartBar({
    super.key,
    required this.totalPrice,
    required this.onPressed,
    this.label = 'কার্টে যোগ করুন',
    this.icon = Icons.shopping_cart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: const Border(
          top: BorderSide(color: AppTheme.divider),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('মোট দাম', style: AppTheme.bodySmall),
                Text(
                  '৳ ${totalPrice.toStringAsFixed(0)}',
                  style: AppTheme.priceBig,
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(icon, size: 18),
                label: Text(label),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
