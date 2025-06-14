// presentation/pages/deposit/pages/bank_selection_page.dart
import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/core/constants/reset_password_scaffold.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/bloc/deposit/deposit_bloc.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/pages/new/payment_details_page.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/widgets/bank_selection_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankSelectionPage extends StatelessWidget {
  const BankSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: 'Deposit', body: BankSelectionForm());
    //  Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Select Bank or Transfer Company')),
    //   body:BankSelectionForm()
    // );
  }
}
