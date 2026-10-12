import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import 'badge_pill.dart';

/// Elite Grocery style প্রোডাক্ট কার্ড।
/// emoji + নাম + দাম + ছাড় + চেকড ব্যাজ।
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── ইমোজি এরিয়া ──
            Stack(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F7F5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    product.emoji,
                    style: const TextStyle(fontSize: 52),
                  ),
                ),
                if (product.discountPercent != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: BadgePill(
                      text: '-${product.discountPercent}%',
                      background: AppTheme.badgeRed,
                    ),
                  ),
                if (product.isNew && product.discountPercent == null)
                  const Positioned(
                    top: 8,
                    left: 8,
                    child: BadgePill(
                      text: 'নতুন',
                      background: Color(0xFFFFC107),
                      foreground: Colors.black87,
                    ),
                  ),
              ],
            ),
            // ── তথ্য ──
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.nameBn,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.body.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'প্রতি ${product.unit}',
                    style: AppTheme.bodySmall.copyWith(fontSize: 10),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '৳ ${product.priceBdt.toStringAsFixed(0)}',
                              style: AppTheme.price.copyWith(fontSize: 15),
                            ),
                            if (product.hasDiscount)
                              Text(
                                '৳ ${product.oldPriceBdt!.toStringAsFixed(0)}',
                                style: AppTheme.oldPrice
                                    .copyWith(fontSize: 11),
                              ),
                          ],
                        ),
                      ),
                      // ── যোগ বাটন ──
                      GestureDetector(
                        onTap: onAdd,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
