/// একটি প্রোডাক্ট (যেমন: আলু, পেঁয়াজ)।
///
/// গুরুত্বপূর্ণ: সব দাম **ডেমো** — বাস্তব বাজারদর নয়।
/// তাই `isDemo = true` রাখা হয়েছে এবং UI-তে "ডেমো" লেবেল দেখানো হবে।
class Product {
  final String id;
  final String nameBn;
  final String categoryId;
  final String unit;
  final double priceBdt;
  final double? oldPriceBdt;
  final bool isDemo;
  final String emoji;
  final bool isPopular;
  final bool isNew;
  final int? discountPercent;
  final DateTime updatedAt;

  const Product({
    required this.id,
    required this.nameBn,
    required this.categoryId,
    required this.unit,
    required this.priceBdt,
    this.oldPriceBdt,
    this.isDemo = true,
    required this.emoji,
    this.isPopular = false,
    this.isNew = false,
    this.discountPercent,
    required this.updatedAt,
  });

  /// ছাড় আছে কি?
  bool get hasDiscount =>
      oldPriceBdt != null && oldPriceBdt! > priceBdt;

  /// ছাড়ের পরিমাণ (টাকায়)
  double get savings =>
      hasDiscount ? (oldPriceBdt! - priceBdt) : 0;
}
