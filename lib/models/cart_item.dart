import 'product.dart';

/// কার্টে একটি আইটেম — প্রোডাক্ট + পরিমাণ।
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  /// এই আইটেমের মোট দাম
  double get subtotal => product.priceBdt * quantity;
}
