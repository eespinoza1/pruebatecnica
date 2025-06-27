// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
//import '../theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;          // claro / oscuro según SO
  ThemeMode get mode => _mode;

  void toggle() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setMode(ThemeMode m) {
    _mode = m;
    notifyListeners();
  }
}
