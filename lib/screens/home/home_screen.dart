import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../data/demo_data.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/product_card.dart';
import '../cart/cart_screen.dart';
import '../category/category_detail_screen.dart';
import '../product/product_detail_screen.dart';
import '../search/search_screen.dart';

/// Elite Grocery style হোম স্ক্রিন।
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // ── AppBar ──
            const _HomeAppBar(),

            // ── Search bar ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SearchScreen(),
                    ),
                  ),
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search,
                            color: AppTheme.textSecondary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'কী খুঁজছেন? (যেমন: আলু, মাছ)',
                          style: AppTheme.bodySmall.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ── হিরো ব্যানার ──
            const SliverToBoxAdapter(child: _HeroBanner()),

            // ── ক্যাটাগরি ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ক্যাটাগরি', style: AppTheme.heading3),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'সব দেখুন',
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: DemoData.categories.length,
                  itemBuilder: (_, i) {
                    final cat = DemoData.categories[i];
                    return CategoryChip(
                      category: cat,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CategoryDetailScreen(category: cat),
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: (i * 60).ms, duration: 400.ms)
                        .slideX(
                          begin: 0.2,
                          end: 0,
                          delay: (i * 60).ms,
                          duration: 400.ms,
                        );
                  },
                ),
              ),
            ),

            // ── Popular ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('জনপ্রিয়', style: AppTheme.heading3),
                    Text(
                      'সব দেখুন',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _ProductGrid(
                products: DemoData.popularProducts().take(6).toList(),
              ),
            ),

            // ── ছাড় ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Text('ছাড়ের অফার', style: AppTheme.heading3),
              ),
            ),
            SliverToBoxAdapter(
              child: _ProductGrid(
                products: DemoData.discountedProducts().take(4).toList(),
              ),
            ),

            // ── ডেমো নোটিশ ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3CD),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE0C97F)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline,
                          color: Color(0xFF7A5C00), size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'সব দাম ডেমো — বাস্তব বাজারদর নয়।',
                          style: AppTheme.bodySmall.copyWith(
                            color: const Color(0xFF7A5C00),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }
}

// ── AppBar ──
class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Row(
          children: [
            const Icon(Icons.menu, color: AppTheme.textPrimary),
            const SizedBox(width: 10),
            Text('বাজারবন্ধু', style: AppTheme.heading2),
            const Spacer(),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined,
                      color: AppTheme.textPrimary),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CartScreen(),
                    ),
                  ),
                ),
                if (cart.totalItems > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: AppTheme.badgeRed,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '${cart.totalItems}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                        .animate()
                        .scale(
                          begin: const Offset(0, 0),
                          end: const Offset(1, 1),
                          duration: 300.ms,
                          curve: Curves.easeOutBack,
                        ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── হিরো ──
class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      height: 130,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '৳১০০ ছাড়',
                  style: AppTheme.bodySmall.copyWith(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'প্রথম অর্ডারে\nবিশেষ ছাড়!',
                  style: AppTheme.heading2.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'এখনই কিনুন',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Text('🛒', style: TextStyle(fontSize: 70)),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.1, end: 0, duration: 500.ms);
  }
}

// ── প্রোডাক্ট গ্রিড ──
class _ProductGrid extends StatelessWidget {
  final List<Product> products;
  const _ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, i) {
          final p = products[i];
          return ProductCard(
            product: p,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: p),
              ),
            ),
            onAdd: () {
              context.read<CartProvider>().add(p);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${p.nameBn} কার্টে যোগ হয়েছে'),
                  duration: const Duration(milliseconds: 800),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          )
              .animate()
              .fadeIn(
                delay: (i * 80).ms,
                duration: 400.ms,
              )
              .slideY(
                begin: 0.2,
                end: 0,
                delay: (i * 80).ms,
                duration: 400.ms,
              );
        },
      ),
    );
  }
}
