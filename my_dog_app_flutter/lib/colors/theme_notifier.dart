// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode =
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
  bool _useSystemTheme = false; // Cambia a false para que no use el sistema

  bool get isDarkMode => _isDarkMode;
  bool get useSystemTheme => _useSystemTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _useSystemTheme = false;
    notifyListeners();
  }
}
