import 'package:flutter/material.dart';

/// বাজারের ক্যাটাগরি (যেমন: সবজি, মাছ, মাংস)।
/// Elite Grocery-এর মতো — emoji + রঙ সহ।
class GroceryCategory {
  final String id;
  final String nameBn;
  final String emoji;
  final Color color;
  final int itemCount;

  const GroceryCategory({
    required this.id,
    required this.nameBn,
    required this.emoji,
    required this.color,
    this.itemCount = 0,
  });
}
