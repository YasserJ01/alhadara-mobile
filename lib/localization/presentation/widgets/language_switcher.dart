// lib/presentation/widgets/language_switcher.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/language.dart';
import '../localization_bloc/localization_bloc.dart';
import '../localization_bloc/localization_event.dart';
import '../localization_bloc/localization_state.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        if (state is LocalizationLoaded) {
          return PopupMenuButton<Language>(
            icon: const Icon(
              Icons.translate,
              color: Colors.white,
            ),
            tooltip: AppLocalizations.of(context).languageSettings,
            onSelected: (Language language) {
              context.read<LocalizationBloc>().add(ChangeLanguage(language));
            },
            itemBuilder: (BuildContext context) {
              return Language.supportedLanguages.map((Language language) {
                return PopupMenuItem<Language>(
                  value: language,
                  child: Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: state.currentLanguage.code == language.code
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        language.nativeName,
                        style: TextStyle(
                          fontWeight: state.currentLanguage.code == language.code
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: state.currentLanguage.code == language.code
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                      ),
                      if (state.currentLanguage.code == language.code)
                        const Spacer(),
                      if (state.currentLanguage.code == language.code)
                        Icon(
                          Icons.check,
                          color: Theme.of(context).primaryColor,
                          size: 16,
                        ),
                    ],
                  ),
                );
              }).toList();
            },
          );
        }

        if (state is LocalizationError) {
          return IconButton(
            icon: const Icon(Icons.error, color: Colors.red),
            onPressed: () {
              context.read<LocalizationBloc>().add(LoadCurrentLanguage());
            },
          );
        }

        return const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        );
      },
    );
  }
}
