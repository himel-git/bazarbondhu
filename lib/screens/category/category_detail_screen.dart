import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../data/demo_data.dart';
import '../../models/category.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/product_card.dart';
import '../product/product_detail_screen.dart';
import 'widgets/filter_chips.dart';
import 'widgets/sort_dropdown.dart';

class CategoryDetailScreen extends StatefulWidget {
  final GroceryCategory category;
  const CategoryDetailScreen({super.key, required this.category});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  ProductFilter _filter = ProductFilter.all;
  ProductSort _sort = ProductSort.nameAsc;

  List<Product> get _filtered {
    var list = DemoData.byCategory(widget.category.id);

    switch (_filter) {
      case ProductFilter.all:
        break;
      case ProductFilter.popular:
        list = list.where((p) => p.isPopular).toList();
        break;
      case ProductFilter.discounted:
        list = list.where((p) => p.hasDiscount).toList();
        break;
      case ProductFilter.newArrival:
        list = list.where((p) => p.isNew).toList();
        break;
    }

    switch (_sort) {
      case ProductSort.nameAsc:
        list.sort((a, b) => a.nameBn.compareTo(b.nameBn));
        break;
      case ProductSort.priceLowHigh:
        list.sort((a, b) => a.priceBdt.compareTo(b.priceBdt));
        break;
      case ProductSort.priceHighLow:
        list.sort((a, b) => b.priceBdt.compareTo(a.priceBdt));
        break;
      case ProductSort.discountFirst:
        list.sort((a, b) {
          final ad = a.discountPercent ?? 0;
          final bd = b.discountPercent ?? 0;
          return bd.compareTo(ad);
        });
        break;
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

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
            title: Row(
              children: [
                Text(widget.category.emoji,
                    style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 8),
                Text(widget.category.nameBn, style: AppTheme.heading3),
              ],
            ),
          ),

          // ── হেডার ──
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.category.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Text(widget.category.emoji,
                      style: const TextStyle(fontSize: 48)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.category.nameBn,
                            style: AppTheme.heading2),
                        const SizedBox(height: 4),
                        Text(
                          '${DemoData.byCategory(widget.category.id).length}টি পণ্য',
                          style: AppTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(
                  begin: 0.1,
                  end: 0,
                  duration: 400.ms,
                ),
          ),

          // ── ফিল্টার ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: FilterChipsRow(
                selected: _filter,
                onChanged: (f) => setState(() => _filter = f),
              ),
            ),
          ),

          // ── Sort + Count ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${items.length}টি পাওয়া গেছে',
                      style: AppTheme.bodySmall),
                  SortDropdown(
                    selected: _sort,
                    onChanged: (s) => setState(() => _sort = s),
                  ),
                ],
              ),
            ),
          ),

          // ── প্রোডাক্ট গ্রিড ──
          if (items.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🔍', style: TextStyle(fontSize: 60)),
                    const SizedBox(height: 12),
                    Text('কোনো পণ্য পাওয়া যায়নি',
                        style: AppTheme.body),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final p = items[i];
                    return ProductCard(
                      product: p,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetailScreen(product: p),
                        ),
                      ),
                      onAdd: () {
                        context.read<CartProvider>().add(p);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${p.nameBn} কার্টে যোগ হয়েছে'),
                            duration:
                                const Duration(milliseconds: 800),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    )
                        .animate()
                        .fadeIn(
                          delay: (i * 60).ms,
                          duration: 350.ms,
                        )
                        .slideY(
                          begin: 0.15,
                          end: 0,
                          delay: (i * 60).ms,
                          duration: 350.ms,
                        );
                  },
                  childCount: items.length,
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
