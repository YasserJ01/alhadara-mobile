// presentation/pages/deposit/pages/method_selection_page.dart
import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/bloc/deposit/deposit_bloc.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/pages/new/bank_selection_page.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/widgets/method_selection_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MethodSelectionPage extends StatelessWidget {
  const MethodSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: BlocProvider(
          create: (context) => getIt<DepositBloc>()..add(LoadDepositMethods()),
          child: MethodSelectionForm(),
        ),
        title: 'Deposit');
  }
}
