import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/address_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../theme/app_theme.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  String _slot = 'আজ বিকাল ৪টা - রাত ৮টা';
  final _slots = [
    'আজ বিকাল ৪টা - রাত ৮টা',
    'আগামীকাল সকাল ৮টা - দুপুর ১২টা',
    'আগামীকাল বিকাল ৪টা - রাত ৮টা',
  ];

  @override
  void initState() {
    super.initState();
    final addr = context.read<AddressProvider>();
    _nameCtrl.text = addr.name;
    _phoneCtrl.text = addr.phone;
    _addressCtrl.text = addr.address;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  void _placeOrder() {
    if (!_formKey.currentState!.validate()) return;

    final cart = context.read<CartProvider>();
    final orderProvider = context.read<OrderProvider>();
    final addressProvider = context.read<AddressProvider>();

    final items = cart.itemList.map((i) => OrderItem(
          productId: i.product.id,
          nameBn: i.product.nameBn,
          unit: i.product.unit,
          priceBdt: i.product.priceBdt,
          quantity: i.quantity,
          emoji: i.product.emoji,
        )).toList();

    final order = Order(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
      placedAt: DateTime.now(),
      name: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
      deliverySlot: _slot,
      items: items,
      subtotal: cart.subtotal,
      delivery: cart.deliveryCharge,
      total: cart.total,
    );

    addressProvider.save(
      name: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
    );

    orderProvider.add(order);
    cart.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OrderSuccessScreen(order: order),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('চেকআউট')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('ডেলিভারি তথ্য', style: AppTheme.heading3),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameCtrl,
              style: AppTheme.body,
              decoration: const InputDecoration(
                labelText: 'আপনার নাম',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'নাম দিন' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              style: AppTheme.body,
              decoration: const InputDecoration(
                labelText: 'মোবাইল নম্বর',
                prefixIcon: Icon(Icons.phone_outlined),
                hintText: '01XXXXXXXXX',
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'নম্বর দিন';
                if (v.trim().length < 11) return '১১ ডিজিট দিন';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _addressCtrl,
              maxLines: 3,
              style: AppTheme.body,
              decoration: const InputDecoration(
                labelText: 'সম্পূর্ণ ঠিকানা',
                prefixIcon: Icon(Icons.location_on_outlined),
                hintText: 'বাসা/রোড/এলাকা',
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'ঠিকানা দিন' : null,
            ),
            const SizedBox(height: 24),
            Text('ডেলিভারি সময়', style: AppTheme.heading3),
            const SizedBox(height: 8),
            ..._slots.map((s) {
              return RadioListTile<String>(
                value: s,
                groupValue: _slot,
                onChanged: (v) => setState(() => _slot = v ?? _slot),
                title: Text(s, style: AppTheme.body),
                activeColor: AppTheme.primaryGreen,
                contentPadding: EdgeInsets.zero,
                dense: true,
              );
            }),
            const SizedBox(height: 24),
            Text('অর্ডার সারসংক্ষেপ', style: AppTheme.heading3),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.divider),
              ),
              child: Column(
                children: [
                  ...cart.itemList.map((i) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Text(i.product.emoji,
                                style: const TextStyle(fontSize: 22)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${i.product.nameBn} × ${i.quantity}',
                                style: AppTheme.body,
                              ),
                            ),
                            Text(
                              '৳ ${i.subtotal.toStringAsFixed(0)}',
                              style: AppTheme.body.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )),
                  const Divider(height: 20),
                  _row('সাবটোটাল', cart.subtotal),
                  const SizedBox(height: 4),
                  _row('ডেলিভারি', cart.deliveryCharge,
                      isFree: cart.deliveryCharge == 0),
                  const Divider(height: 20),
                  Row(
                    children: [
                      Text('মোট', style: AppTheme.heading3),
                      const Spacer(),
                      Text('৳ ${cart.total.toStringAsFixed(0)}',
                          style: AppTheme.priceBig),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _placeOrder,
              icon: const Icon(Icons.check_circle_outline),
              label: Text(
                  'অর্ডার নিশ্চিত করুন • ৳ ${cart.total.toStringAsFixed(0)}'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, double value, {bool isFree = false}) {
    return Row(
      children: [
        Text(label, style: AppTheme.bodySmall),
        const Spacer(),
        Text(
          isFree ? 'ফ্রি' : '৳ ${value.toStringAsFixed(0)}',
          style: AppTheme.body.copyWith(
            fontWeight: FontWeight.w600,
            color: isFree ? AppTheme.primaryGreen : null,
          ),
        ),
      ],
    );
  }
}
