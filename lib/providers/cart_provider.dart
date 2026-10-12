import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/product.dart';
import '../models/cart_item.dart';

/// কার্টের state। Provider দিয়ে সব স্ক্রিনে শেয়ার হবে।
class CartProvider extends ChangeNotifier {
  static const _prefsKey = 'cart_items_v1';

  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => Map.unmodifiable(_items);

  List<CartItem> get itemList => _items.values.toList();

  int get totalItems =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.values.fold(0.0, (sum, item) => sum + item.subtotal);

  /// ডেলিভারি চার্জ (ডেমো) — ৳৫০০+ অর্ডারে ফ্রি
  double get deliveryCharge => subtotal >= 500 ? 0 : 30;

  double get total => subtotal + deliveryCharge;

  bool get isEmpty => _items.isEmpty;

  bool contains(String productId) => _items.containsKey(productId);

  int quantityOf(String productId) =>
      _items[productId]?.quantity ?? 0;

  void add(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += 1;
    } else {
      _items[product.id] = CartItem(product: product, quantity: 1);
    }
    _save();
    notifyListeners();
  }

  void remove(Product product) {
    if (!_items.containsKey(product.id)) return;
    final current = _items[product.id]!.quantity;
    if (current <= 1) {
      _items.remove(product.id);
    } else {
      _items[product.id]!.quantity -= 1;
    }
    _save();
    notifyListeners();
  }

  void removeAll(String productId) {
    _items.remove(productId);
    _save();
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _save();
    notifyListeners();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = _items.values
          .map((item) => {
                'productId': item.product.id,
                'nameBn': item.product.nameBn,
                'categoryId': item.product.categoryId,
                'unit': item.product.unit,
                'priceBdt': item.product.priceBdt,
                'oldPriceBdt': item.product.oldPriceBdt,
                'emoji': item.product.emoji,
                'isDemo': item.product.isDemo,
                'updatedAt': item.product.updatedAt.toIso8601String(),
                'quantity': item.quantity,
              })
          .toList();
      await prefs.setString(_prefsKey, jsonEncode(data));
    } catch (_) {
      // সাইলেন্ট fail — ডেটা সেভ না হলেও অ্যাপ চলবে
    }
  }

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_prefsKey);
      if (raw == null) return;
      final List<dynamic> data = jsonDecode(raw);
      _items.clear();
      for (final entry in data) {
        final map = entry as Map<String, dynamic>;
        final product = Product(
          id: map['productId'] as String,
          nameBn: map['nameBn'] as String,
          categoryId: map['categoryId'] as String,
          unit: map['unit'] as String,
          priceBdt: (map['priceBdt'] as num).toDouble(),
          oldPriceBdt: map['oldPriceBdt'] == null
              ? null
              : (map['oldPriceBdt'] as num).toDouble(),
          emoji: map['emoji'] as String? ?? '🛒',
          isDemo: map['isDemo'] as bool? ?? true,
          updatedAt: DateTime.parse(map['updatedAt'] as String),
        );
        _items[product.id] = CartItem(
          product: product,
          quantity: (map['quantity'] as num).toInt(),
        );
      }
      notifyListeners();
    } catch (_) {
      // সাইলেন্ট fail
    }
  }
}
