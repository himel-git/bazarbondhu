import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../theme/app_theme.dart';
import '../product/product_detail_screen.dart';
import 'widgets/cart_item_tile.dart';
import 'widgets/cart_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.itemList;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('কার্ট'),
        actions: [
          if (items.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              tooltip: 'সব মুছুন',
              onPressed: () => _confirmClear(context),
            ),
        ],
      ),
      body: items.isEmpty
          ? _buildEmpty()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.only(top: 8, bottom: 8),
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final item = items[i];
                      return CartItemTile(
                        item: item,
                        onAdd: () => cart.add(item.product),
                        onRemove: () => cart.remove(item.product),
                        onDelete: () =>
                            cart.removeAll(item.product.id),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(
                                product: item.product),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(
                              delay: (i * 40).ms, duration: 300.ms)
                          .slideX(
                            begin: 0.1,
                            end: 0,
                            delay: (i * 40).ms,
                            duration: 300.ms,
                          );
                    },
                  ),
                ),
                CartSummary(
                  subtotal: cart.subtotal,
                  delivery: cart.deliveryCharge,
                  total: cart.total,
                  onCheckout: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'চেকআউট স্ক্রিন — Phase 8 এ আসবে'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🛒', style: TextStyle(fontSize: 60)),
          const SizedBox(height: 12),
          Text('কার্ট খালি', style: AppTheme.heading3),
          const SizedBox(height: 6),
          Text('Home থেকে পণ্য যোগ করুন',
              style: AppTheme.bodySmall),
        ],
      ).animate().fadeIn(duration: 400.ms),
    );
  }

  void _confirmClear(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('সব মুছবেন?'),
        content:
            const Text('কার্টের সব আইটেম মুছে যাবে।'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('বাতিল'),
          ),
          TextButton(
            onPressed: () {
              context.read<CartProvider>().clear();
              Navigator.pop(context);
            },
            child: const Text('মুছুন',
                style: TextStyle(color: AppTheme.badgeRed)),
          ),
        ],
      ),
    );
  }
}
