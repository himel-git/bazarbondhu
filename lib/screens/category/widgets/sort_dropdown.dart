import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

enum ProductSort {
  nameAsc('নাম (ক → খ)'),
  priceLowHigh('দাম: কম → বেশি'),
  priceHighLow('দাম: বেশি → কম'),
  discountFirst('ছাড় আগে');

  final String labelBn;
  const ProductSort(this.labelBn);
}

class SortDropdown extends StatelessWidget {
  final ProductSort selected;
  final ValueChanged<ProductSort> onChanged;

  const SortDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ProductSort>(
          value: selected,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              size: 18, color: AppTheme.textPrimary),
          style: AppTheme.bodySmall.copyWith(
            color: AppTheme.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          items: ProductSort.values.map((s) {
            return DropdownMenuItem(
              value: s,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.sort, size: 14),
                  const SizedBox(width: 6),
                  Text(s.labelBn),
                ],
              ),
            );
          }).toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}
