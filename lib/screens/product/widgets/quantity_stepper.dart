import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class QuantityStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _btn(
            icon: Icons.remove,
            onTap: onDecrement,
            disabled: quantity <= 1,
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 32),
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: AppTheme.heading3.copyWith(fontSize: 15),
            ),
          ),
          _btn(icon: Icons.add, onTap: onIncrement),
        ],
      ),
    );
  }

  Widget _btn({
    required IconData icon,
    required VoidCallback onTap,
    bool disabled = false,
  }) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: disabled ? const Color(0xFFE0E0E0) : AppTheme.primaryGreen,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: disabled ? const Color(0xFF9E9E9E) : Colors.white,
        ),
      ),
    );
  }
}
