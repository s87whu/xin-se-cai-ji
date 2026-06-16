import 'package:flutter/material.dart';
import 'package:xin_se_cai_ji/persistence/pref.dart';
import 'package:xin_se_cai_ji/common/values/keys.dart';

class ThemeUtil {
  ThemeUtil._();
  static final ThemeUtil instance = ThemeUtil._();
  factory ThemeUtil() => instance;

  ThemeData get lightTheme => ThemeData(
        colorSchemeSeed: const Color(0xFF6750A4),
        useMaterial3: true,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(centerTitle: true),
      );

  ThemeData get darkTheme => ThemeData(
        colorSchemeSeed: const Color(0xFF6750A4),
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(centerTitle: true),
      );

  ThemeMode getThemeMode() {
    final index = PrefUtil.getValue<int>(PrefKeys.themeMode);
    return ThemeMode.values[index];
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await PrefUtil.setValue<int>(PrefKeys.themeMode, mode.index);
  }
}