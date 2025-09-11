// lib/domain/entities/language.dart
import 'package:equatable/equatable.dart';

class Language extends Equatable {
  final String code;
  final String name;
  final String nativeName;

  const Language({
    required this.code,
    required this.name,
    required this.nativeName,
  });

  @override
  List<Object?> get props => [code, name, nativeName];

  static const Language english = Language(
    code: 'en',
    name: 'English',
    nativeName: 'English',
  );

  static const Language arabic = Language(
    code: 'ar',
    name: 'Arabic',
    nativeName: 'العربية',
  );

  static const List<Language> supportedLanguages = [
    english,
    arabic,
  ];

  static Language fromCode(String code) {
    return supportedLanguages.firstWhere(
          (language) => language.code == code,
      orElse: () => english,
    );
  }
}