import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'providers/shopping_list_provider.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BazarBondhuApp());
}

class BazarBondhuApp extends StatelessWidget {
  const BazarBondhuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()..load()),
        ChangeNotifierProvider(
            create: (_) => ShoppingListProvider()..load()),
      ],
      child: MaterialApp(
        title: 'বাজারবন্ধু',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const SplashScreen(),
      ),
    );
  }
}
