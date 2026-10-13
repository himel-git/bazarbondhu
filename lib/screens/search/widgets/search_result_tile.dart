import 'package:flutter/material.dart';
import '../../../models/product.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/badge_pill.dart';

class SearchResultTile extends StatelessWidget {
  final Product product;
  final String query;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  const SearchResultTile({
    super.key,
    required this.product,
    required this.query,
    this.onTap,
    this.onAdd,
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
              child: Text(product.emoji,
                  style: const TextStyle(fontSize: 32)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _highlightedText(
                          product.nameBn,
                          query,
                          AppTheme.body.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (product.discountPercent != null)
                        BadgePill(
                          text: '-${product.discountPercent}%',
                          background: AppTheme.badgeRed,
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text('প্রতি ${product.unit}',
                      style: AppTheme.bodySmall.copyWith(fontSize: 11)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '৳ ${product.priceBdt.toStringAsFixed(0)}',
                        style: AppTheme.price.copyWith(fontSize: 15),
                      ),
                      if (product.hasDiscount) ...[
                        const SizedBox(width: 6),
                        Text(
                          '৳ ${product.oldPriceBdt!.toStringAsFixed(0)}',
                          style: AppTheme.oldPrice
                              .copyWith(fontSize: 11),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onAdd,
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppTheme.primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _highlightedText(String text, String query, TextStyle style) {
    if (query.isEmpty) return Text(text, style: style);
    final lower = text.toLowerCase();
    final q = query.toLowerCase();
    final idx = lower.indexOf(q);
    if (idx == -1) return Text(text, style: style);
    return RichText(
      text: TextSpan(
        style: style,
        children: [
          TextSpan(text: text.substring(0, idx)),
          TextSpan(
            text: text.substring(idx, idx + q.length),
            style: style.copyWith(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(text: text.substring(idx + q.length)),
        ],
      ),
    );
  }
}
