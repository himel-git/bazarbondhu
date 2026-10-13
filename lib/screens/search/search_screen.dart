import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../data/demo_data.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_theme.dart';
import '../product/product_detail_screen.dart';
import 'widgets/search_result_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Product> get _results {
    if (_query.trim().isEmpty) return [];
    final q = _query.trim().toLowerCase();
    return DemoData.products().where((p) {
      return p.nameBn.toLowerCase().contains(q) ||
          p.categoryId.toLowerCase().contains(q) ||
          p.unit.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    final showPopular = _query.trim().isEmpty;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('খুঁজুন'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _controller,
              onChanged: (v) => setState(() => _query = v),
              style: AppTheme.body,
              decoration: InputDecoration(
                hintText: 'পণ্যের নাম লিখুন (যেমন: আলু, মাছ)',
                prefixIcon: const Icon(Icons.search,
                    color: AppTheme.textSecondary),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
      body: showPopular
          ? _buildSuggestions()
          : results.isEmpty
              ? _buildEmpty()
              : _buildResults(results),
    );
  }

  Widget _buildSuggestions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('জনপ্রিয় খোঁজ', style: AppTheme.heading3),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'আলু',
              'পেঁয়াজ',
              'মাছ',
              'মুরগি',
              'চাল',
              'ডিম',
              'তেল',
              'দুধ'
            ].map((tag) {
              return GestureDetector(
                onTap: () {
                  _controller.text = tag;
                  setState(() => _query = tag);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.divider),
                  ),
                  child: Text(tag, style: AppTheme.body),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text('সব ক্যাটাগরি', style: AppTheme.heading3),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: DemoData.categories.map((c) {
              return GestureDetector(
                onTap: () {
                  _controller.text = c.nameBn;
                  setState(() => _query = c.nameBn);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: c.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(c.emoji,
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text(c.nameBn,
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              );
            }).toList(),
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
          const Text('🔍', style: TextStyle(fontSize: 60)),
          const SizedBox(height: 12),
          Text('"$_query" — কোনো পণ্য পাওয়া যায়নি',
              style: AppTheme.body),
          const SizedBox(height: 8),
          Text('অন্য কীওয়ার্ড দিয়ে চেষ্টা করুন',
              style: AppTheme.bodySmall),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildResults(List<Product> results) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Text('${results.length}টি পাওয়া গেছে',
              style: AppTheme.bodySmall),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: results.length,
            itemBuilder: (context, i) {
              final p = results[i];
              return SearchResultTile(
                product: p,
                query: _query,
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
                  .fadeIn(delay: (i * 40).ms, duration: 300.ms)
                  .slideX(
                    begin: 0.1,
                    end: 0,
                    delay: (i * 40).ms,
                    duration: 300.ms,
                  );
            },
          ),
        ),
      ],
    );
  }
}
