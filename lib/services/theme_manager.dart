
import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeData => _themeMode;

  toggleThme(bool isDark){
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }
}