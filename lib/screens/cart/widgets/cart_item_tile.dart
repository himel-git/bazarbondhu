import 'package:flutter/material.dart';
import '../../../models/cart_item.dart';
import '../../../theme/app_theme.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.divider),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7F5),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(item.product.emoji,
                  style: const TextStyle(fontSize: 32)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.nameBn,
                    style: AppTheme.body.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '৳ ${item.product.priceBdt.toStringAsFixed(0)} / ${item.product.unit}',
                    style: AppTheme.bodySmall.copyWith(fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'সাবটোটাল: ৳ ${item.subtotal.toStringAsFixed(0)}',
                    style: AppTheme.price.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: onDelete,
                  child: const Icon(Icons.delete_outline,
                      size: 18, color: AppTheme.badgeRed),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _btn(Icons.remove, onRemove),
                    Container(
                      constraints: const BoxConstraints(minWidth: 30),
                      alignment: Alignment.center,
                      child: Text('${item.quantity}',
                          style: AppTheme.heading3
                              .copyWith(fontSize: 14)),
                    ),
                    _btn(Icons.add, onAdd),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _btn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }
}
