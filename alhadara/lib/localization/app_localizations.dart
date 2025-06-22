import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'onboarding_title_1': 'ACCESS YOUR COURSES ANYTIME',
      'onboarding_desc_1': 'Study at your own pace with full access to your learning materials, anytime and anywhere.',
      'onboarding_title_2': 'Work Seamlessly',
      'onboarding_desc_2': 'Get your work done seamlessly without interruption',
      'onboarding_title_3': 'Achieve Higher Goals',
      'onboarding_desc_3': 'By boosting your productivity we help you achieve higher goals',
      'next_button': 'NEXT',
      'get_started_button': 'GET STARTED',
      'skip_button': 'Skip Tour',
    },
    'ar': {
      'onboarding_title_1': 'الوصول إلى دوراتك في أي وقت',
      'onboarding_desc_1': 'ادرس حسب سرعتك مع الوصول الكامل إلى موادك التعليمية في أي وقت ومن أي مكان.',
      'onboarding_title_2': 'العمل بسلاسة',
      'onboarding_desc_2': 'أنهِ عملك بسلاسة دون انقطاع',
      'onboarding_title_3': 'تحقيق أهداف أعلى',
      'onboarding_desc_3': 'من خلال تعزيز إنتاجيتك نساعدك في تحقيق أهداف أعلى',
      'next_button': 'التالي',
      'get_started_button': 'ابدأ الآن',
      'skip_button': 'تخطي الجولة',
    },
  };

  String? get onboardingTitle1 {
    return _localizedValues[locale.languageCode]?['onboarding_title_1'];
  }

  String? get onboardingDesc1 {
    return _localizedValues[locale.languageCode]?['onboarding_desc_1'];
  }

  String? get onboardingTitle2 {
    return _localizedValues[locale.languageCode]?['onboarding_title_2'];
  }

  String? get onboardingDesc2 {
    return _localizedValues[locale.languageCode]?['onboarding_desc_2'];
  }

  String? get onboardingTitle3 {
    return _localizedValues[locale.languageCode]?['onboarding_title_3'];
  }

  String? get onboardingDesc3 {
    return _localizedValues[locale.languageCode]?['onboarding_desc_3'];
  }

  String? get nextButton {
    return _localizedValues[locale.languageCode]?['next_button'];
  }

  String? get getStartedButton {
    return _localizedValues[locale.languageCode]?['get_started_button'];
  }

  String? get skipButton {
    return _localizedValues[locale.languageCode]?['skip_button'];
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    Intl.defaultLocale = locale.languageCode;
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}