import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// "ডেমো" লেবেল ব্যাজ — ডেমো ডেটার জন্য, যাতে ইউজার বিভ্রান্ত না হয়।
///
/// এই ব্যাজ অ্যাপের যেকোনো জায়গায় ব্যবহার করা যাবে যেখানে
/// `Product.isDemo == true`। ভবিষ্যতে Verified দাম এলে সেটার জন্য
/// আলাদা `VerifiedBadge` বানানো হবে।
class DemoBadge extends StatelessWidget {
  /// কাস্টম লেবেল। না দিলে "ডেমো দাম" দেখাবে।
  final String? label;

  /// কমপ্যাক্ট মোড (আরও ছোট ফন্ট, padding কম)।
  final bool compact;

  const DemoBadge({
    super.key,
    this.label,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final double hPad = compact ? 6 : 8;
    final double vPad = compact ? 2 : 3;
    final double fontSize = compact ? 10 : 11;
    final double iconSize = compact ? 10 : 12;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      decoration: BoxDecoration(
        color: AppTheme.demoBadgeBg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE0C97F)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_outline,
            size: iconSize,
            color: AppTheme.demoBadgeFg,
          ),
          SizedBox(width: compact ? 3 : 4),
          Text(
            label ?? 'ডেমো দাম',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: AppTheme.demoBadgeFg,
            ),
          ),
        ],
      ),
    );
  }
}
