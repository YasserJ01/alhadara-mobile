// presentation/pages/deposit/pages/method_selection_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_scaffold.dart';
import '../../../../dependencies.dart';
import '../bloc/deposit_methods/deposit_methods_bloc.dart';
import '../widgets/method_selection_form.dart';

class MethodSelectionPage extends StatelessWidget {
  const MethodSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: BlocProvider(
        create: (context) => getIt<DepositBloc>()..add(LoadDepositMethods()),
        child: MethodSelectionForm(),
      ),
      title: 'Deposit',
    );
  }
}