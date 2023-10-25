import 'package:flutter/material.dart';
class ThemeProvider extends ChangeNotifier {
  ThemeData? currentTheme = ThemeData.light().copyWith(appBarTheme: const AppBarTheme(foregroundColor: Colors.black));
  bool isLight = true;

  switchTheme() {
    isLight = !isLight;
    if (isLight) {
      currentTheme = ThemeData.light().copyWith(appBarTheme: const AppBarTheme(foregroundColor: Colors.black));
    } else {
      currentTheme = ThemeData.dark().copyWith();
    }
    notifyListeners();
  }
}
