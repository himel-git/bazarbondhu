import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../providers/order_provider.dart';
import '../../theme/app_theme.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('আমার অর্ডার')),
      body: orders.isEmpty
          ? _buildEmpty()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, i) => _orderCard(orders[i], i),
            ),
    );
  }

  Widget _orderCard(Order order, int i) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 14),
        title: Text(order.id,
            style: AppTheme.body.copyWith(fontWeight: FontWeight.w700)),
        subtitle: Text(
          '${order.placedAt.day}/${order.placedAt.month}/${order.placedAt.year} • ${order.items.length}টি',
          style: AppTheme.bodySmall.copyWith(fontSize: 11),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('৳ ${order.total.toStringAsFixed(0)}',
                style: AppTheme.price.copyWith(fontSize: 14)),
            const SizedBox(height: 2),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3CD),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(order.status,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF7A5C00),
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                ...order.items.map((it) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Text(it.emoji,
                              style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${it.nameBn} × ${it.quantity} ${it.unit}',
                              style: AppTheme.bodySmall,
                            ),
                          ),
                          Text(
                            '৳ ${it.subtotal.toStringAsFixed(0)}',
                            style: AppTheme.bodySmall.copyWith(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )),
                const Divider(),
                const SizedBox(height: 6),
                _row(Icons.location_on_outlined, 'ঠিকানা', order.address),
                const SizedBox(height: 6),
                _row(Icons.schedule, 'ডেলিভারি', order.deliverySlot),
                const SizedBox(height: 6),
                _row(Icons.phone_outlined, 'মোবাইল', order.phone),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (i * 50).ms, duration: 300.ms);
  }

  Widget _row(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: AppTheme.textSecondary),
        const SizedBox(width: 6),
        Text('$label: ', style: AppTheme.bodySmall),
        Expanded(
          child: Text(value,
              style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('📦', style: TextStyle(fontSize: 60)),
          const SizedBox(height: 12),
          Text('কোনো অর্ডার নেই', style: AppTheme.heading3),
          const SizedBox(height: 6),
          Text('এখনো কোনো অর্ডার করেননি',
              style: AppTheme.bodySmall),
        ],
      ).animate().fadeIn(duration: 400.ms),
    );
  }
}
