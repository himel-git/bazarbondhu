import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OrderItem {
  final String productId;
  final String nameBn;
  final String unit;
  final double priceBdt;
  final int quantity;
  final String emoji;

  const OrderItem({
    required this.productId,
    required this.nameBn,
    required this.unit,
    required this.priceBdt,
    required this.quantity,
    required this.emoji,
  });

  double get subtotal => priceBdt * quantity;

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'nameBn': nameBn,
        'unit': unit,
        'priceBdt': priceBdt,
        'quantity': quantity,
        'emoji': emoji,
      };

  factory OrderItem.fromJson(Map<String, dynamic> map) => OrderItem(
        productId: map['productId'] as String,
        nameBn: map['nameBn'] as String,
        unit: map['unit'] as String,
        priceBdt: (map['priceBdt'] as num).toDouble(),
        quantity: (map['quantity'] as num).toInt(),
        emoji: map['emoji'] as String? ?? '🛒',
      );
}

class Order {
  final String id;
  final DateTime placedAt;
  final String name;
  final String phone;
  final String address;
  final String deliverySlot;
  final List<OrderItem> items;
  final double subtotal;
  final double delivery;
  final double total;
  final String status;

  const Order({
    required this.id,
    required this.placedAt,
    required this.name,
    required this.phone,
    required this.address,
    required this.deliverySlot,
    required this.items,
    required this.subtotal,
    required this.delivery,
    required this.total,
    this.status = 'প্রস্তুত হচ্ছে',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'placedAt': placedAt.toIso8601String(),
        'name': name,
        'phone': phone,
        'address': address,
        'deliverySlot': deliverySlot,
        'items': items.map((i) => i.toJson()).toList(),
        'subtotal': subtotal,
        'delivery': delivery,
        'total': total,
        'status': status,
      };

  factory Order.fromJson(Map<String, dynamic> map) => Order(
        id: map['id'] as String,
        placedAt: DateTime.parse(map['placedAt'] as String),
        name: map['name'] as String,
        phone: map['phone'] as String,
        address: map['address'] as String,
        deliverySlot: map['deliverySlot'] as String,
        items: (map['items'] as List)
            .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        subtotal: (map['subtotal'] as num).toDouble(),
        delivery: (map['delivery'] as num).toDouble(),
        total: (map['total'] as num).toDouble(),
        status: map['status'] as String? ?? 'প্রস্তুত হচ্ছে',
      );
}

class OrderProvider extends ChangeNotifier {
  static const _prefsKey = 'orders_v1';

  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders.reversed.toList());

  int get totalOrders => _orders.length;

  Future<void> add(Order order) async {
    _orders.add(order);
    await _save();
    notifyListeners();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _prefsKey,
        jsonEncode(_orders.map((o) => o.toJson()).toList()),
      );
    } catch (_) {}
  }

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_prefsKey);
      if (raw == null) return;
      final List<dynamic> data = jsonDecode(raw);
      _orders.clear();
      for (final e in data) {
        _orders.add(Order.fromJson(e as Map<String, dynamic>));
      }
      notifyListeners();
    } catch (_) {}
  }
}
