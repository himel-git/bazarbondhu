import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../providers/shopping_list_provider.dart';
import '../../theme/app_theme.dart';
import 'widgets/add_item_sheet.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final list = context.watch<ShoppingListProvider>();
    final items = list.items;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('শপিং তালিকা'),
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
          ? _buildEmpty(context)
          : Column(
              children: [
                _buildSummaryCard(list),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 100),
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final item = items[i];
                      return Dismissible(
                        key: ValueKey(item.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          padding:
                              const EdgeInsets.only(right: 20),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: AppTheme.badgeRed,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.delete,
                              color: Colors.white),
                        ),
                        onDismissed: (_) => list.remove(item.id),
                        child: _itemTile(context, list, item, i),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSheet(context),
        backgroundColor: AppTheme.primaryGreen,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('আইটেম যোগ করুন',
            style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _itemTile(BuildContext context, ShoppingListProvider list,
      ShoppingItem item, int i) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => list.toggle(item.id),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: item.isChecked
                    ? AppTheme.primaryGreen
                    : Colors.transparent,
                border: Border.all(
                  color: item.isChecked
                      ? AppTheme.primaryGreen
                      : AppTheme.textSecondary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: item.isChecked
                  ? const Icon(Icons.check,
                      size: 16, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nameBn,
                  style: AppTheme.body.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: item.isChecked
                        ? TextDecoration.lineThrough
                        : null,
                    color: item.isChecked
                        ? AppTheme.textSecondary
                        : AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.quantity.toStringAsFixed(item.quantity == item.quantity.round() ? 0 : 1)} ${item.unit} × ৳${item.priceBdt.toStringAsFixed(0)}',
                  style: AppTheme.bodySmall.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '৳ ${item.subtotal.toStringAsFixed(0)}',
                style: AppTheme.price.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _miniBtn(Icons.remove,
                      () => _changeQty(list, item, -1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text('${item.quantity.toInt()}',
                        style: AppTheme.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        )),
                  ),
                  _miniBtn(Icons.add,
                      () => _changeQty(list, item, 1)),
                ],
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: (i * 40).ms, duration: 300.ms);
  }

  Widget _miniBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 14, color: AppTheme.textPrimary),
      ),
    );
  }

  void _changeQty(ShoppingListProvider list, ShoppingItem item, int delta) {
    final nv = item.quantity + delta;
    if (nv < 1) {
      list.remove(item.id);
    } else {
      list.updateQuantity(item.id, nv);
    }
  }

  Widget _buildSummaryCard(ShoppingListProvider list) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryGreen, AppTheme.accentGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.receipt_long,
                  color: Colors.white70, size: 18),
              const SizedBox(width: 6),
              Text('সারসংক্ষেপ',
                  style: AppTheme.bodySmall
                      .copyWith(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _stat('মোট আইটেম', '${list.totalItems}'),
              _stat('সম্পন্ন', '${list.checkedCount}'),
              _stat('আনুমানিক খরচ',
                  '৳ ${list.totalCost.toStringAsFixed(0)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTheme.bodySmall
                  .copyWith(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 4),
          Text(value,
              style: AppTheme.heading3.copyWith(
                color: Colors.white,
                fontSize: 16,
              )),
        ],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('📝', style: TextStyle(fontSize: 60)),
          const SizedBox(height: 12),
          Text('শপিং তালিকা খালি', style: AppTheme.heading3),
          const SizedBox(height: 6),
          Text('নিচের বাটন থেকে আইটেম যোগ করুন',
              style: AppTheme.bodySmall),
        ],
      ).animate().fadeIn(duration: 400.ms),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddItemSheet(),
    );
  }

  void _confirmClear(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('সব মুছবেন?'),
        content: const Text('শপিং তালিকার সব আইটেম মুছে যাবে।'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('বাতিল'),
          ),
          TextButton(
            onPressed: () {
              context.read<ShoppingListProvider>().clearAll();
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
