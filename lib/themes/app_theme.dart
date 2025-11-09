import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  ThemeMode lightDark = ThemeMode.system;
  bool isLight = (ThemeMode.light == ThemeMode.system);

  void toggleTheme() {
    isLight = !isLight;
    isLight ? lightDark = ThemeMode.light : lightDark = ThemeMode.dark;
    notifyListeners();
  }

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(elevation: 5, centerTitle: true),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 5),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,

      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(elevation: 5, centerTitle: true),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 5),
  );
}
