import 'package:flutter/material.dart';
import 'package:carentalapp/themes/light_mode.dart';
import 'package:carentalapp/themes/dark_mode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = darkMode;

  ThemeData get themeData => _themeData;

  bool get isLightMode => _themeData == lightMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData; 
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == darkMode) {
      themeData = lightMode;
    } else {
      themeData = darkMode;
      }
    }
  }
