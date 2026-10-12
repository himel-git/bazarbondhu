import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// শপিং লিস্টের একটি আইটেম।
class ShoppingItem {
  final String id;
  final String nameBn;
  final String unit;
  double priceBdt;
  double quantity;
  bool isChecked;

  ShoppingItem({
    required this.id,
    required this.nameBn,
    this.unit = 'কেজি',
    this.priceBdt = 0,
    this.quantity = 1,
    this.isChecked = false,
  });

  double get subtotal => priceBdt * quantity;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nameBn': nameBn,
        'unit': unit,
        'priceBdt': priceBdt,
        'quantity': quantity,
        'isChecked': isChecked,
      };

  factory ShoppingItem.fromJson(Map<String, dynamic> map) => ShoppingItem(
        id: map['id'] as String,
        nameBn: map['nameBn'] as String,
        unit: map['unit'] as String? ?? 'কেজি',
        priceBdt: (map['priceBdt'] as num).toDouble(),
        quantity: (map['quantity'] as num).toDouble(),
        isChecked: map['isChecked'] as bool? ?? false,
      );
}

/// শপিং লিস্টের state।
class ShoppingListProvider extends ChangeNotifier {
  static const _prefsKey = 'shopping_list_v1';

  final List<ShoppingItem> _items = [];

  List<ShoppingItem> get items => List.unmodifiable(_items);

  int get totalItems => _items.length;

  int get checkedCount =>
      _items.where((it) => it.isChecked).length;

  double get totalCost => _items.fold(0.0, (s, it) => s + it.subtotal);

  double get checkedCost => _items
      .where((it) => it.isChecked)
      .fold(0.0, (s, it) => s + it.subtotal);

  void add(ShoppingItem item) {
    _items.add(item);
    _save();
    notifyListeners();
  }

  void remove(String id) {
    _items.removeWhere((it) => it.id == id);
    _save();
    notifyListeners();
  }

  void toggle(String id) {
    final idx = _items.indexWhere((it) => it.id == id);
    if (idx == -1) return;
    _items[idx].isChecked = !_items[idx].isChecked;
    _save();
    notifyListeners();
  }

  void updateQuantity(String id, double quantity) {
    final idx = _items.indexWhere((it) => it.id == id);
    if (idx == -1) return;
    _items[idx].quantity = quantity;
    _save();
    notifyListeners();
  }

  void updatePrice(String id, double price) {
    final idx = _items.indexWhere((it) => it.id == id);
    if (idx == -1) return;
    _items[idx].priceBdt = price;
    _save();
    notifyListeners();
  }

  void clearAll() {
    _items.clear();
    _save();
    notifyListeners();
  }

  void clearChecked() {
    _items.removeWhere((it) => it.isChecked);
    _save();
    notifyListeners();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _prefsKey,
        jsonEncode(_items.map((it) => it.toJson()).toList()),
      );
    } catch (_) {}
  }

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_prefsKey);
      if (raw == null) return;
      final List<dynamic> data = jsonDecode(raw);
      _items.clear();
      for (final e in data) {
        _items.add(ShoppingItem.fromJson(e as Map<String, dynamic>));
      }
      notifyListeners();
    } catch (_) {}
  }
}
