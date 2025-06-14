// presentation/pages/deposit/pages/payment_details_page.dart
import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/bloc/deposit/deposit_bloc.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/widgets/payment_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentDetailsPage extends StatelessWidget {
  const PaymentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: PaymentDetailsForm(), title: 'Deposit');
  }
}
