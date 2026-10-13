import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressProvider extends ChangeNotifier {
  static const _nameKey = 'user_name';
  static const _phoneKey = 'user_phone';
  static const _addressKey = 'user_address';

  String _name = '';
  String _phone = '';
  String _address = '';

  String get name => _name;
  String get phone => _phone;
  String get address => _address;

  bool get hasData => _name.isNotEmpty && _phone.isNotEmpty;

  Future<void> save({
    required String name,
    required String phone,
    required String address,
  }) async {
    _name = name;
    _phone = phone;
    _address = address;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_nameKey, name);
      await prefs.setString(_phoneKey, phone);
      await prefs.setString(_addressKey, address);
    } catch (_) {}
    notifyListeners();
  }

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _name = prefs.getString(_nameKey) ?? '';
      _phone = prefs.getString(_phoneKey) ?? '';
      _address = prefs.getString(_addressKey) ?? '';
      notifyListeners();
    } catch (_) {}
  }
}
