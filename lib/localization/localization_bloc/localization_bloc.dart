import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part  'localization_event.dart';
part  'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final SharedPreferences prefs;
  static const String _localeKey = 'selected_locale';

  LocalizationBloc({required this.prefs}) : super(const SelectedLocale(Locale('en'))) {
    on<ChangeLocale>(_onChangeLocale);
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final languageCode = prefs.getString(_localeKey);
    if (languageCode != null) {
      emit(SelectedLocale(Locale(languageCode)));
    }
  }

  Future<void> _onChangeLocale(
      ChangeLocale event,
      Emitter<LocalizationState> emit,
      ) async {
    await prefs.setString(_localeKey, event.locale.languageCode);
    emit(SelectedLocale(event.locale));
  }
}