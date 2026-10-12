import 'package:flutter/material.dart';
import '../data/demo_data.dart';
import '../theme/app_theme.dart';
import '../widgets/demo_badge.dart';

/// হোম স্ক্রিন — অ্যাপ খোলার পর প্রথম যা দেখা যায়।
///
/// Phase 3 এ শুধু লেআউট ও ডেমো ডেটা দেখানো হচ্ছে।
/// Phase 4-7 এ ক্যাটাগরি ট্যাপ, সার্চ, তুলনা, শপিং লিস্ট — সব
/// আলাদা স্ক্রিনে নিয়ে যাওয়া হবে।
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('বাজারবন্ধু'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'অ্যাপ সম্পর্কে',
            onPressed: () => _showAbout(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          _HeroBanner(),
          const SizedBox(height: 8),
          _SectionHeader(title: 'বাজার (মার্কেট)'),
          _MarketCard(),
          const SizedBox(height: 8),
          _SectionHeader(title: 'ক্যাটাগরি'),
          _CategoryGrid(),
          const SizedBox(height: 8),
          _SectionHeader(title: 'আজকের ডেমো দাম'),
          _DemoNotice(),
          const SizedBox(height: 6),
          _ProductPreview(),
        ],
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('বাজারবন্ধু সম্পর্কে'),
        content: const SingleChildScrollView(
          child: Text(
            'বাজারবন্ধু একটি ডেমো অ্যাপ যা বাংলাদেশের বাজারের দাম '
            'তুলনা করতে সাহায্য করবে।\n\n'
            'প্রাথমিক বাজার: কারওয়ান বাজার, ঢাকা।\n\n'
            '⚠️ বর্তমানে অ্যাপে কোনো বাস্তব দাম নেই — সব ডেমো। '
            'বাস্তব দাম শুধু ব্যবহারকারীর রিপোর্ট থেকে যোগ হবে।',
            style: TextStyle(height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('বন্ধ করুন'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// নিচের সব ক্লাস শুধু home_screen.dart এর ভিতরে ব্যবহৃত হবে।
// বড় স্ক্রিন হলে আলাদা ফাইলে সরানো যাবে, কিন্তু এখন কোড পড়া
// সহজ রাখতে এক ফাইলেই রাখা হলো।
// ─────────────────────────────────────────────────────────────

/// গ্রেডিয়েন্ট হিরো ব্যানার — অ্যাপের "প্রথম ছাপ"।
class _HeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryGreen, AppTheme.accentGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'স্বাগতম 👋',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            'বাংলাদেশের বাজারদর\nতুলনা করুন',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'শুরু করুন কারওয়ান বাজার, ঢাকা থেকে',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

/// সেকশন হেডার — "বাজার", "ক্যাটাগরি" ইত্যাদি শিরোনাম।
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }
}

/// মার্কেট কার্ড — এখন শুধু কারওয়ান বাজার।
class _MarketCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppTheme.primaryGreen,
          child: Icon(Icons.storefront, color: Colors.white),
        ),
        title: const Text(
          'কারওয়ান বাজার',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: const Text('ঢাকা, বাংলাদেশ'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('একাধিক মার্কেট পরে যোগ করা হবে'),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}

/// ক্যাটাগরি গ্রিড — ৮টি ক্যাটাগরি ২ কলামে।
class _CategoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: DemoData.categories.length,
        itemBuilder: (context, index) {
          final cat = DemoData.categories[index];
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${cat.nameBn} — শীঘ্রই আসছে (Phase 4)'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: cat.color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Row(
                children: [
                  Text(cat.emoji, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      cat.nameBn,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// হলুদ সতর্কবার্তা — দাম ডেমো বলে স্পষ্টভাবে জানানো।
class _DemoNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.demoBadgeBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0C97F)),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: AppTheme.demoBadgeFg),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'নিচের সব দাম ডেমো — বাস্তব বাজারদর নয়। '
              'শুধু অ্যাপ পরীক্ষা করার জন্য।',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.demoBadgeFg,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// প্রথম ৫টি প্রোডাক্টের প্রিভিউ কার্ড।
class _ProductPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = DemoData.products().take(5).toList();
    return Column(
      children: products.map((p) {
        return Card(
          child: ListTile(
            title: Text(
              p.nameBn,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Text('প্রতি ${p.unit}',
                      style: const TextStyle(fontSize: 12)),
                  const SizedBox(width: 6),
                  const DemoBadge(compact: true),
                ],
              ),
            ),
            trailing: Text(
              '৳ ${p.demoPriceBdt.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryGreen,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
