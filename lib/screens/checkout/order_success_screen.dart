import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../providers/order_provider.dart';
import '../../theme/app_theme.dart';
import '../main_shell.dart';

class OrderSuccessScreen extends StatelessWidget {
  final Order order;
  const OrderSuccessScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFFE3F3E7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle,
                    color: AppTheme.primaryGreen, size: 80),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.3, 0.3),
                    end: const Offset(1, 1),
                    duration: 600.ms,
                    curve: Curves.easeOutBack,
                  )
                  .fadeIn(duration: 400.ms),
              const SizedBox(height: 24),
              Text('অর্ডার সফল!',
                      style: AppTheme.heading1.copyWith(fontSize: 26))
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 400.ms)
                  .slideY(
                      begin: 0.2,
                      end: 0,
                      delay: 300.ms,
                      duration: 400.ms),
              const SizedBox(height: 10),
              Text(
                'আপনার অর্ডার নিশ্চিত হয়েছে',
                style: AppTheme.body
                    .copyWith(color: AppTheme.textSecondary),
              ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.divider),
                ),
                child: Column(
                  children: [
                    _row('অর্ডার আইডি', order.id),
                    const Divider(height: 20),
                    _row('মোট', '৳ ${order.total.toStringAsFixed(0)}'),
                    const Divider(height: 20),
                    _row('ডেলিভারি সময়', order.deliverySlot),
                    const Divider(height: 20),
                    _row('আইটেম', '${order.items.length}টি'),
                  ],
                ),
              ).animate().fadeIn(delay: 700.ms, duration: 400.ms),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MainShell(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text('হোমে ফিরে যান'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                ),
              ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      children: [
        Text(label, style: AppTheme.bodySmall),
        const Spacer(),
        Text(
          value,
          style: AppTheme.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
