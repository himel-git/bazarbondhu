import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/product.dart';

/// ⚠️ সতর্কতা: এই ফাইলের সব দাম **ডেমো** — বাস্তব বাজারদর নয়।
/// এগুলো শুধু অ্যাপ ডেভেলপমেন্ট ও UI টেস্টের জন্য।
class DemoData {
  DemoData._();

  static final DateTime _updated = DateTime(2026, 1, 1);

  static const List<GroceryCategory> categories = [
    GroceryCategory(
      id: 'vegetables',
      nameBn: 'সবজি',
      emoji: '🥬',
      color: Color(0xFFE8F5E9),
    ),
    GroceryCategory(
      id: 'fish',
      nameBn: 'মাছ',
      emoji: '🐟',
      color: Color(0xFFE3F2FD),
    ),
    GroceryCategory(
      id: 'meat',
      nameBn: 'মাংস',
      emoji: '🍖',
      color: Color(0xFFFFEBEE),
    ),
    GroceryCategory(
      id: 'rice_grain',
      nameBn: 'চাল ও দানাদার',
      emoji: '🍚',
      color: Color(0xFFFFF8E1),
    ),
    GroceryCategory(
      id: 'oil_spice',
      nameBn: 'তেল ও মসলা',
      emoji: '🌶️',
      color: Color(0xFFFBE9E7),
    ),
    GroceryCategory(
      id: 'egg_dairy',
      nameBn: 'ডিম ও দুধ',
      emoji: '🥚',
      color: Color(0xFFFFFDE7),
    ),
    GroceryCategory(
      id: 'fruits',
      nameBn: 'ফল',
      emoji: '🍎',
      color: Color(0xFFFCE4EC),
    ),
    GroceryCategory(
      id: 'other',
      nameBn: 'অন্যান্য',
      emoji: '🛒',
      color: Color(0xFFF1F8E9),
    ),
  ];

  static List<Product> products() => [
        Product(
          id: 'alu',
          nameBn: 'আলু',
          categoryId: 'vegetables',
          unit: 'কেজি',
          demoPriceBdt: 45,
          updatedAt: _updated,
        ),
        Product(
          id: 'peyaj',
          nameBn: 'পেঁয়াজ (দেশি)',
          categoryId: 'vegetables',
          unit: 'কেজি',
          demoPriceBdt: 110,
          updatedAt: _updated,
        ),
        Product(
          id: 'roshun',
          nameBn: 'রসুন',
          categoryId: 'vegetables',
          unit: 'কেজি',
          demoPriceBdt: 180,
          updatedAt: _updated,
        ),
        Product(
          id: 'ada',
          nameBn: 'আদা',
          categoryId: 'vegetables',
          unit: 'কেজি',
          demoPriceBdt: 220,
          updatedAt: _updated,
        ),
        Product(
          id: 'begun',
          nameBn: 'বেগুন',
          categoryId: 'vegetables',
          unit: 'কেজি',
          demoPriceBdt: 60,
          updatedAt: _updated,
        ),
        Product(
          id: 'tomato',
          nameBn: 'টমেটো',
          categoryId: 'vegetables',
          unit: 'কেজি',
          demoPriceBdt: 80,
          updatedAt: _updated,
        ),
        Product(
          id: 'rui',
          nameBn: 'রুই মাছ',
          categoryId: 'fish',
          unit: 'কেজি',
          demoPriceBdt: 380,
          updatedAt: _updated,
        ),
        Product(
          id: 'tilapia',
          nameBn: 'তেলাপিয়া',
          categoryId: 'fish',
          unit: 'কেজি',
          demoPriceBdt: 200,
          updatedAt: _updated,
        ),
        Product(
          id: 'ilish',
          nameBn: 'ইলিশ',
          categoryId: 'fish',
          unit: 'কেজি',
          demoPriceBdt: 1500,
          updatedAt: _updated,
        ),
        Product(
          id: 'chicken_broiler',
          nameBn: 'মুরগি (ব্রয়লার)',
          categoryId: 'meat',
          unit: 'কেজি',
          demoPriceBdt: 180,
          updatedAt: _updated,
        ),
        Product(
          id: 'beef',
          nameBn: 'গরুর মাংস',
          categoryId: 'meat',
          unit: 'কেজি',
          demoPriceBdt: 750,
          updatedAt: _updated,
        ),
        Product(
          id: 'rice_miniket',
          nameBn: 'মিনিকেট চাল',
          categoryId: 'rice_grain',
          unit: 'কেজি',
          demoPriceBdt: 70,
          updatedAt: _updated,
        ),
        Product(
          id: 'rice_najir',
          nameBn: 'নাজিরশাইল চাল',
          categoryId: 'rice_grain',
          unit: 'কেজি',
          demoPriceBdt: 80,
          updatedAt: _updated,
        ),
        Product(
          id: 'dal_masur',
          nameBn: 'মসুর ডাল',
          categoryId: 'rice_grain',
          unit: 'কেজি',
          demoPriceBdt: 130,
          updatedAt: _updated,
        ),
        Product(
          id: 'oil_soybean',
          nameBn: 'সয়াবিন তেল',
          categoryId: 'oil_spice',
          unit: 'লিটার',
          demoPriceBdt: 170,
          updatedAt: _updated,
        ),
        Product(
          id: 'holud',
          nameBn: 'হলুদ গুঁড়া',
          categoryId: 'oil_spice',
          unit: 'কেজি',
          demoPriceBdt: 320,
          updatedAt: _updated,
        ),
        Product(
          id: 'lonka_gura',
          nameBn: 'মরিচ গুঁড়া',
          categoryId: 'oil_spice',
          unit: 'কেজি',
          demoPriceBdt: 380,
          updatedAt: _updated,
        ),
        Product(
          id: 'egg',
          nameBn: 'ডিম (ফার্ম)',
          categoryId: 'egg_dairy',
          unit: 'ডজন',
          demoPriceBdt: 130,
          updatedAt: _updated,
        ),
        Product(
          id: 'milk',
          nameBn: 'গরুর দুধ',
          categoryId: 'egg_dairy',
          unit: 'লিটার',
          demoPriceBdt: 90,
          updatedAt: _updated,
        ),
        Product(
          id: 'kola',
          nameBn: 'কলা (সাগর)',
          categoryId: 'fruits',
          unit: 'ডজন',
          demoPriceBdt: 60,
          updatedAt: _updated,
        ),
      ];
}
