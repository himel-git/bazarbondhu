import 'package:flutter/material.dart';

/// বাজারের ক্যাটাগরি (যেমন: সবজি, মাছ, মাংস)।
class GroceryCategory {
  final String id;
  final String nameBn;
  final String emoji;
  final Color color;

  const GroceryCategory({
    required this.id,
    required this.nameBn,
    required this.emoji,
    required this.color,
  });
}
