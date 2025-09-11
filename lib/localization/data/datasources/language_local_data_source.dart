// lib/data/datasources/language_local_data_source.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/storage_keys.dart';
import '../models/language_model.dart';
import '../../domain/entities/language.dart';

abstract class LanguageLocalDataSource {
  Future<LanguageModel> getCurrentLanguage();
  Future<void> saveLanguage(Language language);
  Future<void> clearLanguage();
}

@Injectable(as: LanguageLocalDataSource)
class LanguageLocalDataSourceImpl implements LanguageLocalDataSource {
  final SharedPreferences sharedPreferences;

  LanguageLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<LanguageModel> getCurrentLanguage() async {
    final languageCode = sharedPreferences.getString(StorageKeys.languageCode);

    if (languageCode == null) {
      // Return default language (English)
      return const LanguageModel(
        code: 'en',
        name: 'English',
        nativeName: 'English',
      );
    }

    // Find language by code
    final language = Language.supportedLanguages.firstWhere(
          (lang) => lang.code == languageCode,
      orElse: () => Language.english,
    );

    return LanguageModel.fromEntity(language);
  }

  @override
  Future<void> saveLanguage(Language language) async {
    await sharedPreferences.setString(StorageKeys.languageCode, language.code);
  }

  @override
  Future<void> clearLanguage() async {
    await sharedPreferences.remove(StorageKeys.languageCode);
  }
}
