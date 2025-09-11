// lib/presentation/widgets/language_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/language.dart';
import '../localization_bloc/localization_bloc.dart';
import '../localization_bloc/localization_event.dart';
import '../localization_bloc/localization_state.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LanguageBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              AppLocalizations.of(context).languageSettings,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(162, 12, 13, 1.0),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).selectLanguage,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Language options
            BlocBuilder<LocalizationBloc, LocalizationState>(
              builder: (context, state) {
                if (state is LocalizationLoaded) {
                  return Column(
                    children: Language.supportedLanguages.map((language) {
                      final isSelected = state.currentLanguage.code == language.code;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          onTap: () {
                            context.read<LocalizationBloc>().add(
                              ChangeLanguage(language),
                            );
                            Navigator.pop(context);
                          },
                          leading: Icon(
                            Icons.language,
                            color: isSelected
                                ? const Color.fromRGBO(162, 12, 13, 1.0)
                                : Colors.grey,
                          ),
                          title: Text(
                            language.nativeName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected
                                  ? const Color.fromRGBO(162, 12, 13, 1.0)
                                  : Colors.black87,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                            Icons.check_circle,
                            color: Color.fromRGBO(162, 12, 13, 1.0),
                          )
                              : const Icon(
                            Icons.radio_button_unchecked,
                            color: Colors.grey,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: isSelected
                                  ? const Color.fromRGBO(162, 12, 13, 1.0)
                                  : Colors.grey[300]!,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          tileColor: isSelected
                              ? const Color.fromRGBO(162, 12, 13, 0.1)
                              : Colors.transparent,
                        ),
                      );
                    }).toList(),
                  );
                }

                if (state is LocalizationLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(162, 12, 13, 1.0),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}