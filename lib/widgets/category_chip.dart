import 'package:flutter/material.dart';
import '../models/category.dart';
import '../theme/app_theme.dart';

/// Elite style ক্যাটাগরি চিপ — emoji + নাম + সবুজ "View More" কার্ড।
class CategoryChip extends StatelessWidget {
  final GroceryCategory category;
  final VoidCallback? onTap;

  const CategoryChip({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 88,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: category.color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryGreen.withOpacity(0.15),
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                category.emoji,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.nameBn,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
