class ThemeEntity {
  final bool isDarkMode;
  final String textColor;
  final String backgroundColor;

  const ThemeEntity({
    required this.isDarkMode,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeEntity &&
        other.isDarkMode == isDarkMode &&
        other.textColor == textColor &&
        other.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode => isDarkMode.hashCode ^ textColor.hashCode ^ backgroundColor.hashCode;
}