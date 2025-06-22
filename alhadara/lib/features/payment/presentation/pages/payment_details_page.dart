// presentation/pages/deposit/pages/payment_details_page.dart

import 'package:flutter/material.dart';
import '../../../../core/constants/app_scaffold.dart';
import '../widgets/payment_details_form.dart';

class PaymentDetailsPage extends StatelessWidget {
  const PaymentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: PaymentDetailsForm(),
      title: 'Deposit',
    );
  }
}
