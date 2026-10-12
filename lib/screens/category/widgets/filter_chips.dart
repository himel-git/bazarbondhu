import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

enum ProductFilter {
  all('সব', Icons.apps),
  popular('জনপ্রিয়', Icons.local_fire_department),
  discounted('ছাড়', Icons.local_offer),
  newArrival('নতুন', Icons.fiber_new);

  final String labelBn;
  final IconData icon;
  const ProductFilter(this.labelBn, this.icon);
}

class FilterChipsRow extends StatelessWidget {
  final ProductFilter selected;
  final ValueChanged<ProductFilter> onChanged;

  const FilterChipsRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: ProductFilter.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final f = ProductFilter.values[i];
          final isSelected = f == selected;
          return GestureDetector(
            onTap: () => onChanged(f),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryGreen
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.primaryGreen
                      : const Color(0xFFE0E0E0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    f.icon,
                    size: 14,
                    color: isSelected
                        ? Colors.white
                        : AppTheme.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    f.labelBn,
                    style: AppTheme.bodySmall.copyWith(
                      color: isSelected
                          ? Colors.white
                          : AppTheme.textPrimary,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
