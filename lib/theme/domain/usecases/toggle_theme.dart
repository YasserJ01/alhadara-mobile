import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';

class ToggleTheme {
  final ThemeRepository repository;

  ToggleTheme(this.repository);

  Future<ThemeEntity> call() async {
    await repository.toggleTheme();
    return await repository.getCurrentTheme();
  }
}