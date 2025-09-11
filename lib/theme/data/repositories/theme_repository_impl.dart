import '../../domain/entities/theme_entity.dart';
import '../../domain/repositories/theme_repository.dart';
import '../datasources/theme_local_datasource.dart';
import '../models/theme_model.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl({required this.localDataSource});

  @override
  Future<ThemeEntity> getCurrentTheme() async {
    try {
      final themeModel = await localDataSource.getCachedTheme();
      return themeModel;
    } catch (e) {
      // Return default theme if error occurs
      return ThemeModel.light();
    }
  }

  @override
  Future<bool> isDarkMode() async {
    try {
      return await localDataSource.isDarkMode();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> saveTheme(ThemeEntity theme) async {
    final themeModel = ThemeModel(
      isDarkMode: theme.isDarkMode,
      textColor: theme.textColor,
      backgroundColor: theme.backgroundColor,
    );
    await localDataSource.cacheTheme(themeModel);
  }

  @override
  Future<void> toggleTheme() async {
    final currentTheme = await getCurrentTheme();
    final newTheme = currentTheme.isDarkMode ? ThemeModel.light() : ThemeModel.dark();
    await saveTheme(newTheme);
  }
}
