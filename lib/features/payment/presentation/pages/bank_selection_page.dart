// presentation/pages/deposit/pages/bank_selection_page.dart
import 'package:flutter/material.dart';
import 'package:project2/l10n/generated/app_localizations.dart';

import '../../../../core/constants/app_scaffold.dart';
import '../widgets/bank_selection_form.dart';

class BankSelectionPage extends StatelessWidget {
  const BankSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return  AppScaffold(
      title: l10n.deposit,
      body: const BankSelectionForm(),
    );
    //  Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Select Bank or Transfer Company')),
    //   body:BankSelectionForm()
    // );
  }
}
