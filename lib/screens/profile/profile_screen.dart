import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../providers/address_provider.dart';
import '../../providers/order_provider.dart';
import '../../theme/app_theme.dart';
import '../report/report_price_screen.dart';
import 'my_orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addr = context.watch<AddressProvider>();
    final orders = context.watch<OrderProvider>();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(title: const Text('প্রোফাইল')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primaryGreen, AppTheme.accentGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child:
                      const Text('👤', style: TextStyle(fontSize: 30)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        addr.name.isEmpty
                            ? 'অতিথি ব্যবহারকারী'
                            : addr.name,
                        style: AppTheme.heading3.copyWith(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        addr.phone.isEmpty
                            ? 'প্রোফাইল সেট করুন'
                            : addr.phone,
                        style: AppTheme.bodySmall.copyWith(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: 20),
          Row(
            children: [
              _statCard('মোট অর্ডার', '${orders.totalOrders}'),
              const SizedBox(width: 10),
              _statCard('কার্ট', '০'),
              const SizedBox(width: 10),
              _statCard('তালিকা', '০'),
            ],
          ),
          const SizedBox(height: 20),
          Text('আমার কার্যক্রম', style: AppTheme.heading3),
          const SizedBox(height: 10),
          _menuTile(
            context,
            icon: Icons.receipt_long,
            title: 'আমার অর্ডার',
            subtitle: '${orders.totalOrders}টি অর্ডার',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MyOrdersScreen(),
              ),
            ),
          ),
          _menuTile(
            context,
            icon: Icons.location_on_outlined,
            title: 'ডেলিভারি ঠিকানা',
            subtitle: addr.address.isEmpty
                ? 'সেট করুন'
                : addr.address.length > 30
                    ? '${addr.address.substring(0, 30)}...'
                    : addr.address,
            onTap: () => _showAddressDialog(context),
          ),
          _menuTile(
            context,
            icon: Icons.report_problem_outlined,
            title: 'দাম রিপোর্ট করুন',
            subtitle: 'বাজারের দাম জানান',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ReportPriceScreen(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('সেটিংস', style: AppTheme.heading3),
          const SizedBox(height: 10),
          _menuTile(
            context,
            icon: Icons.info_outline,
            title: 'অ্যাপ সম্পর্কে',
            subtitle: 'BazarBondhu v0.2.0',
            onTap: () => _showAbout(context),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.divider),
        ),
        child: Column(
          children: [
            Text(value,
                style: AppTheme.heading2
                    .copyWith(color: AppTheme.primaryGreen)),
            const SizedBox(height: 4),
            Text(label,
                style: AppTheme.bodySmall.copyWith(fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
        ),
        title: Text(title,
            style: AppTheme.body.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle,
            style: AppTheme.bodySmall.copyWith(fontSize: 11)),
        trailing: const Icon(Icons.chevron_right,
            color: AppTheme.textSecondary),
      ),
    );
  }

  void _showAddressDialog(BuildContext context) {
    final addr = context.read<AddressProvider>();
    final nameCtrl = TextEditingController(text: addr.name);
    final phoneCtrl = TextEditingController(text: addr.phone);
    final addrCtrl = TextEditingController(text: addr.address);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('ঠিকানা সম্পাদনা'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'নাম'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration:
                    const InputDecoration(labelText: 'মোবাইল নম্বর'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: addrCtrl,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'ঠিকানা'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('বাতিল'),
          ),
          TextButton(
            onPressed: () {
              addr.save(
                name: nameCtrl.text.trim(),
                phone: phoneCtrl.text.trim(),
                address: addrCtrl.text.trim(),
              );
              Navigator.pop(context);
            },
            child: const Text('সেভ করুন'),
          ),
        ],
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('বাজারবন্ধু সম্পর্কে'),
        content: const Text(
          'বাংলাদেশের বাজারদর ও ডেলিভারি অ্যাপ।\n\n'
          '⚠️ সব দাম ডেমো — বাস্তব নয়।\n\n'
          'সংস্করণ: 0.2.0',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ঠিক আছে'),
          ),
        ],
      ),
    );
  }
}
