import 'package:flutter/material.dart';

import '../../data/demo_data.dart';
import '../../theme/app_theme.dart';

class ReportPriceScreen extends StatefulWidget {
  const ReportPriceScreen({super.key});

  @override
  State<ReportPriceScreen> createState() => _ReportPriceScreenState();
}

class _ReportPriceScreenState extends State<ReportPriceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _priceCtrl = TextEditingController();
  final _shopCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  String? _selectedProduct;

  @override
  void dispose() {
    _priceCtrl.dispose();
    _shopCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedProduct == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('পণ্য নির্বাচন করুন')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.check_circle,
                color: AppTheme.primaryGreen, size: 24),
            SizedBox(width: 8),
            Text('রিপোর্ট জমা হয়েছে'),
          ],
        ),
        content: const Text(
          'আপনার রিপোর্ট আমরা পেয়েছি। '
          'যাচাই করার পর যোগ করা হবে।\n\n'
          '⚠️ ডেমো সংস্করণে কোনো আসল রিপোর্ট সংরক্ষণ হয়নি।',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('ঠিক আছে'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = DemoData.products();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('দাম রিপোর্ট করুন')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3CD),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0C97F)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      color: Color(0xFF7A5C00), size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'ডেমো সংস্করণ — আপনার রিপোর্ট কোথাও পাঠানো হবে না। '
                      'আসল ভার্সনে বাজারের তথ্যে যোগ হবে।',
                      style: AppTheme.bodySmall.copyWith(
                        color: const Color(0xFF7A5C00),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text('পণ্য নির্বাচন করুন', style: AppTheme.heading3),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedProduct,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'পণ্য',
                hintText: 'পণ্য বাছুন',
              ),
              items: products.map((p) {
                return DropdownMenuItem(
                  value: p.id,
                  child: Text('${p.emoji}  ${p.nameBn}'),
                );
              }).toList(),
              onChanged: (v) => setState(() => _selectedProduct = v),
              validator: (v) =>
                  v == null ? 'পণ্য নির্বাচন করুন' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _priceCtrl,
              keyboardType: TextInputType.number,
              style: AppTheme.body,
              decoration: const InputDecoration(
                labelText: 'আপনি যে দামে দেখেছেন (৳)',
                prefixIcon: Icon(Icons.attach_money),
                hintText: '0',
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'দাম দিন';
                final n = double.tryParse(v.trim());
                if (n == null || n <= 0) return 'বৈধ দাম দিন';
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _shopCtrl,
              style: AppTheme.body,
              decoration: const InputDecoration(
                labelText: 'দোকানের নাম / এলাকা',
                prefixIcon: Icon(Icons.store_outlined),
                hintText: 'যেমন: কারওয়ান বাজার, দোকান-৩',
              ),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _noteCtrl,
              maxLines: 3,
              style: AppTheme.body,
              decoration: const InputDecoration(
                labelText: 'অতিরিক্ত তথ্য (ঐচ্ছিক)',
                hintText: 'যেমন: আজ ভোরে দেখা দাম',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.send, size: 18),
              label: const Text('রিপোর্ট পাঠান'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '⚠️ আপনার পাঠানো তথ্য সঠিক হলে আমরা যাচাই করে '
              'অ্যাপে যোগ করব। ভুল তথ্য দিলে রিপোর্ট বাতিল হবে।',
              style: AppTheme.bodySmall.copyWith(
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
