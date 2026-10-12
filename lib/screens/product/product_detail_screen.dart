import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/shopping_list_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/add_to_cart_bar.dart';
import '../../widgets/badge_pill.dart';
import 'widgets/quantity_stepper.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  double get _subtotal => widget.product.priceBdt * _quantity;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final cart = context.watch<CartProvider>();
    final inCart = cart.quantityOf(p.id);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          // ── AppBar ──
          SliverAppBar(
            pinned: true,
            backgroundColor: AppTheme.surface,
            foregroundColor: AppTheme.textPrimary,
            elevation: 0.5,
            title: Text(p.nameBn, style: AppTheme.heading3),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () => Navigator.pop(context),
                  ),
                  if (cart.totalItems > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppTheme.badgeRed,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.totalItems}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          // ── হিরো ইমোজি ──
          SliverToBoxAdapter(
            child: Container(
              height: 240,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7F5),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Hero(
                tag: 'product-${p.id}',
                child: Text(
                  p.emoji,
                  style: const TextStyle(fontSize: 120),
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1, 1),
                  duration: 400.ms,
                  curve: Curves.easeOut,
                ),
          ),

          // ── নাম, ব্যাজ ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (p.discountPercent != null)
                        BadgePill(
                          text: '-${p.discountPercent}%',
                          background: AppTheme.badgeRed,
                        ),
                      if (p.discountPercent != null)
                        const SizedBox(width: 6),
                      if (p.isNew)
                        const BadgePill(
                          text: 'নতুন',
                          background: Color(0xFFFFC107),
                          foreground: Colors.black87,
                        ),
                      if (p.isPopular)
                        const Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: BadgePill(
                            text: '🔥 জনপ্রিয়',
                            background: Color(0xFFFF6F00),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(p.nameBn, style: AppTheme.heading1),
                  const SizedBox(height: 4),
                  Text(
                    'প্রতি ${p.unit} • ${p.categoryId}',
                    style: AppTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),

          // ── দাম ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '৳ ${p.priceBdt.toStringAsFixed(0)}',
                    style: AppTheme.priceBig.copyWith(fontSize: 28),
                  ),
                  if (p.hasDiscount) ...[
                    const SizedBox(width: 10),
                    Text(
                      '৳ ${p.oldPriceBdt!.toStringAsFixed(0)}',
                      style: AppTheme.oldPrice.copyWith(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F3E7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '৳${p.savings.toStringAsFixed(0)} সাশ্রয়',
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // ── ডেমো নোটিশ ──
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3CD),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE0C97F)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      size: 16, color: Color(0xFF7A5C00)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'এই দাম ডেমো — বাস্তব বাজারদর নয়।',
                      style: AppTheme.bodySmall.copyWith(
                        color: const Color(0xFF7A5C00),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Quantity + Actions ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  Text('পরিমাণ', style: AppTheme.heading3),
                  const Spacer(),
                  QuantityStepper(
                    quantity: _quantity,
                    onIncrement: () =>
                        setState(() => _quantity += 1),
                    onDecrement: () {
                      if (_quantity > 1) {
                        setState(() => _quantity -= 1);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          // ── ইনফো কার্ড ──
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.divider),
              ),
              child: Column(
                children: [
                  _infoRow(Icons.shopping_bag_outlined, 'ইউনিট', p.unit),
                  const Divider(height: 20),
                  _infoRow(Icons.category_outlined, 'ক্যাটাগরি',
                      p.categoryId),
                  const Divider(height: 20),
                  _infoRow(
                    Icons.update,
                    'শেষ আপডেট',
                    '${p.updatedAt.day}/${p.updatedAt.month}/${p.updatedAt.year}',
                  ),
                  if (inCart > 0) ...[
                    const Divider(height: 20),
                    _infoRow(
                      Icons.shopping_cart,
                      'কার্টে আছে',
                      '$inCart ${p.unit}',
                      valueColor: AppTheme.primaryGreen,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // ── শপিং লিস্টে যোগ ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
              child: OutlinedButton.icon(
                onPressed: () {
                  context
                      .read<ShoppingListProvider>()
                      .add(ShoppingItem(
                        id: p.id,
                        nameBn: p.nameBn,
                        unit: p.unit,
                        priceBdt: p.priceBdt,
                        quantity: _quantity.toDouble(),
                      ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${p.nameBn} শপিং তালিকায় যোগ হয়েছে'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.list_alt, size: 18),
                label: const Text('শপিং তালিকায় যোগ করুন'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryGreen,
                  side: const BorderSide(
                      color: AppTheme.primaryGreen, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AddToCartBar(
        totalPrice: _subtotal,
        onPressed: () {
          for (var i = 0; i < _quantity; i++) {
            context.read<CartProvider>().add(p);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  '$_quantity ${p.unit} ${p.nameBn} কার্টে যোগ হয়েছে'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value,
      {Color? valueColor}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.textSecondary),
        const SizedBox(width: 10),
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
