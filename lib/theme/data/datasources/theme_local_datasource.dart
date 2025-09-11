import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/theme_model.dart';

abstract class ThemeLocalDataSource {
  Future<ThemeModel> getCachedTheme();
  Future<void> cacheTheme(ThemeModel themeModel);
  Future<bool> isDarkMode();
  Future<void> setDarkMode(bool isDarkMode);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _themeKey = 'CACHED_THEME';
  static const String _isDarkModeKey = 'IS_DARK_MODE';

  ThemeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ThemeModel> getCachedTheme() async {
    final jsonString = sharedPreferences.getString(_themeKey);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      return ThemeModel.fromJson(jsonMap);
    } else {
      // Return default light theme
      return ThemeModel.light();
    }
  }

  @override
  Future<void> cacheTheme(ThemeModel themeModel) async {
    final jsonString = json.encode(themeModel.toJson());
    await sharedPreferences.setString(_themeKey, jsonString);
    await sharedPreferences.setBool(_isDarkModeKey, themeModel.isDarkMode);
  }

  @override
  Future<bool> isDarkMode() async {
    return sharedPreferences.getBool(_isDarkModeKey) ?? false;
  }

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    await sharedPreferences.setBool(_isDarkModeKey, isDarkMode);
  }
}