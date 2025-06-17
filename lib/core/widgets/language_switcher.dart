import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/localization/localization_bloc/localization_bloc.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);

    return DropdownButton<Locale>(
      value: currentLocale,
      items: const [
        DropdownMenuItem(
          value: Locale('en'),
          child: Text('English'),
        ),
        DropdownMenuItem(
          value: Locale('ar'),
          child: Text('العربية'),
        ),
      ],
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          context.read<LocalizationBloc>().add(ChangeLocale(newLocale));
        }
      },
    );
  }
}