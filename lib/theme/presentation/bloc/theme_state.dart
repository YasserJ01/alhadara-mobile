import '../../domain/entities/theme_entity.dart';

abstract class ThemeState {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  const ThemeInitial();
}

class ThemeLoading extends ThemeState {
  const ThemeLoading();
}

class ThemeLoaded extends ThemeState {
  final ThemeEntity theme;

  const ThemeLoaded({required this.theme});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeLoaded && other.theme == theme;
  }

  @override
  int get hashCode => theme.hashCode;
}

class ThemeError extends ThemeState {
  final String message;

  const ThemeError({required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
