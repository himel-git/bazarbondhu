import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class CartSummary extends StatelessWidget {
  final double subtotal;
  final double delivery;
  final double total;
  final VoidCallback onCheckout;
  final bool enabled;

  const CartSummary({
    super.key,
    required this.subtotal,
    required this.delivery,
    required this.total,
    required this.onCheckout,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: const Border(top: BorderSide(color: AppTheme.divider)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _row('সাবটোটাল', '৳ ${subtotal.toStringAsFixed(0)}'),
            const SizedBox(height: 6),
            _row(
              'ডেলিভারি চার্জ',
              delivery == 0
                  ? 'ফ্রি'
                  : '৳ ${delivery.toStringAsFixed(0)}',
              valueColor:
                  delivery == 0 ? AppTheme.primaryGreen : null,
            ),
            const Divider(height: 20),
            Row(
              children: [
                Text('মোট', style: AppTheme.heading3),
                const Spacer(),
                Text('৳ ${total.toStringAsFixed(0)}',
                    style: AppTheme.priceBig),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: enabled ? onCheckout : null,
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: const Text('চেকআউট করুন'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor:
                    enabled ? AppTheme.primaryGreen : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {Color? valueColor}) {
    return Row(
      children: [
        Text(label, style: AppTheme.bodySmall),
        const Spacer(),
        Text(
          value,
          style: AppTheme.body.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
