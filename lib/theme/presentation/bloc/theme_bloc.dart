import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_current_theme.dart';
import '../../domain/usecases/toggle_theme.dart';
import '../../domain/usecases/save_theme.dart';
import '../../data/models/theme_model.dart';
import 'theme_event.dart';
import 'theme_state.dart';
//theme_bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetCurrentTheme getCurrentTheme;
  final ToggleTheme toggleTheme;
  final SaveTheme saveTheme;

  ThemeBloc({
    required this.getCurrentTheme,
    required this.toggleTheme,
    required this.saveTheme,
  }) : super(const ThemeInitial()) {

    on<LoadTheme>(_onLoadTheme);
    on<ToggleThemeMode>(_onToggleTheme);
    on<SetLightTheme>(_onSetLightTheme);
    on<SetDarkTheme>(_onSetDarkTheme);
  }

  void _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    emit(const ThemeLoading());
    try {
      final theme = await getCurrentTheme();
      emit(ThemeLoaded(theme: theme));
    } catch (e) {
      emit(ThemeError(message: 'Failed to load theme: ${e.toString()}'));
      // Emit default theme as fallback
      emit(ThemeLoaded(theme: ThemeModel.light()));
    }
  }

  void _onToggleTheme(ToggleThemeMode event, Emitter<ThemeState> emit) async {
    try {
      final newTheme = await toggleTheme();
      emit(ThemeLoaded(theme: newTheme));
    } catch (e) {
      emit(ThemeError(message: 'Failed to toggle theme: ${e.toString()}'));
    }
  }

  void _onSetLightTheme(SetLightTheme event, Emitter<ThemeState> emit) async {
    try {
      final lightTheme = ThemeModel.light();
      await saveTheme(lightTheme);
      emit(ThemeLoaded(theme: lightTheme));
    } catch (e) {
      emit(ThemeError(message: 'Failed to set light theme: ${e.toString()}'));
    }
  }

  void _onSetDarkTheme(SetDarkTheme event, Emitter<ThemeState> emit) async {
    try {
      final darkTheme = ThemeModel.dark();
      await saveTheme(darkTheme);
      emit(ThemeLoaded(theme: darkTheme));
    } catch (e) {
      emit(ThemeError(message: 'Failed to set dark theme: ${e.toString()}'));
    }
  }
}
