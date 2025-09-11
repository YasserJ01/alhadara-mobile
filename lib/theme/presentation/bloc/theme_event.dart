abstract class ThemeEvent {
  const ThemeEvent();
}

class LoadTheme extends ThemeEvent {
  const LoadTheme();
}

class ToggleThemeMode extends ThemeEvent {
  const ToggleThemeMode();
}

class SetLightTheme extends ThemeEvent {
  const SetLightTheme();
}

class SetDarkTheme extends ThemeEvent {
  const SetDarkTheme();
}