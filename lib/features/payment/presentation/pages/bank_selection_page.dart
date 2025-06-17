// presentation/pages/deposit/pages/bank_selection_page.dart
import 'package:flutter/material.dart';

import '../../../../core/constants/app_scaffold.dart';
import '../widgets/bank_selection_form.dart';

class BankSelectionPage extends StatelessWidget {
  const BankSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Deposit',
      body: BankSelectionForm(),
    );
    //  Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Select Bank or Transfer Company')),
    //   body:BankSelectionForm()
    // );
  }
}
