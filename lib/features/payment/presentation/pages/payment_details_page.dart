// presentation/pages/deposit/pages/payment_details_page.dart

import 'package:flutter/material.dart';
import 'package:project2/l10n/generated/app_localizations.dart';
import '../../../../core/constants/app_scaffold.dart';
import '../widgets/payment_details_form.dart';

class PaymentDetailsPage extends StatelessWidget {
  const PaymentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return  AppScaffold(
      body: const PaymentDetailsForm(),
      title: l10n.deposit,
    );
  }
}
