import 'package:flutter/material.dart';

/// ছোট ব্যাজ — "NEW", "AD", "৳xx ছাড়" ইত্যাদির জন্য।
class BadgePill extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;
  final EdgeInsets padding;

  const BadgePill({
    super.key,
    required this.text,
    this.background = const Color(0xFFD32F2F),
    this.foreground = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
