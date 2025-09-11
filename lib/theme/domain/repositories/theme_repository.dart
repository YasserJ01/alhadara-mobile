import '../entities/theme_entity.dart';

abstract class ThemeRepository {
  Future<ThemeEntity> getCurrentTheme();
  Future<void> saveTheme(ThemeEntity theme);
  Future<bool> isDarkMode();
  Future<void> toggleTheme();
}