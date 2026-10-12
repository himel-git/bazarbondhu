/// একটি প্রোডাক্ট (যেমন: আলু, পেঁয়াজ)।
///
/// গুরুত্বপূর্ণ: এই অ্যাপে সব দাম **ডেমো ডেটা** — বাস্তব বাজারদর নয়।
/// তাই `isDemo = true` রাখা হয়েছে এবং UI-তে "ডেমো" লেবেল দেখানো হবে।
class Product {
  final String id;
  final String nameBn;
  final String categoryId;
  final String unit;         // যেমন: "কেজি", "পিস", "ডজন"
  final double demoPriceBdt; // ডেমো দাম, BDT
  final bool isDemo;         // সব ডেমো ডেটার জন্য true
  final DateTime updatedAt;

  const Product({
    required this.id,
    required this.nameBn,
    required this.categoryId,
    required this.unit,
    required this.demoPriceBdt,
    this.isDemo = true,
    required this.updatedAt,
  });
}

/// একটি প্রোডাক্টের দামের হিস্ট্রি (পরে ভেরিফায়েড রিপোর্ট থেকে আসবে)।
class PriceEntry {
  final String productId;
  final String marketId;       // যেমন: "karwan_bazar"
  final double priceBdt;
  final String unit;
  final DateTime reportedAt;
  final bool isVerified;       // true হলে বাস্তব রিপোর্ট, false হলে ডেমো

  const PriceEntry({
    required this.productId,
    required this.marketId,
    required this.priceBdt,
    required this.unit,
    required this.reportedAt,
    this.isVerified = false,
  });
}
