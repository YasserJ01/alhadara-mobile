import '../../domain/entities/theme_entity.dart';

class ThemeModel extends ThemeEntity {
  const ThemeModel({
    required bool isDarkMode,
    required String textColor,
    required String backgroundColor,
  }) : super(
    isDarkMode: isDarkMode,
    textColor: textColor,
    backgroundColor: backgroundColor,
  );

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      isDarkMode: json['isDarkMode'] ?? false,
      textColor: json['textColor'] ?? '#A20C0D',
      backgroundColor: json['backgroundColor'] ?? '#FFFFFF',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'textColor': textColor,
      'backgroundColor': backgroundColor,
    };
  }

  factory ThemeModel.light() {
    return const ThemeModel(
      isDarkMode: false,
      textColor: '#A20C0D',  // Color.fromRGBO(162, 12, 13, 1.0)
      backgroundColor: '#FFFFFF',
    );
  }

  factory ThemeModel.dark() {
    return const ThemeModel(
      isDarkMode: true,
      textColor: '#FF6B6B',  // Professional red for dark mode
      backgroundColor: '#1A1A1A',  // Professional dark background
    );
  }

  ThemeModel copyWith({
    bool? isDarkMode,
    String? textColor,
    String? backgroundColor,
  }) {
    return ThemeModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}