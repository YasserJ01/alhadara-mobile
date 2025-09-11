import 'package:flutter/material.dart';

import '../../theme/domain/entities/theme_entity.dart';

//app_theme_helper.dart
class AppThemeHelper {
  static Color getTextColor(ThemeEntity theme) {
    return Color(int.parse(theme.textColor.replaceFirst('#', '0xFF')));
  }

  static Color getBackgroundColor(ThemeEntity theme) {
    return Color(int.parse(theme.backgroundColor.replaceFirst('#', '0xFF')));
  }

  static Color getCardColor(ThemeEntity theme) {
    return theme.isDarkMode ? const Color(0xFF2D2D2D) : Colors.white;
  }

  static Color getSecondaryTextColor(ThemeEntity theme) {
    return theme.isDarkMode ? Colors.white70 : Colors.black54;
  }

  static Color getIconColor(ThemeEntity theme) {
    return theme.isDarkMode ? Colors.white : const Color.fromRGBO(162, 12, 13, 1.0);
  }

  static Brightness getBrightness(ThemeEntity theme) {
    return theme.isDarkMode ? Brightness.dark : Brightness.light;
  }
}