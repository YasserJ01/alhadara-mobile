// pages/withdraw/pages/withdraw_page.dart
import '../../../../core/constants/app_scaffold.dart';
import '../../../../dependencies.dart';
import '../../domain/usecases/create_withdrawal_request.dart';
import '../bloc/withdraw/withdrawal_bloc.dart';
import '../widgets/withdraw_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WithdrawPage extends StatelessWidget {
  const WithdrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Withdraw ',
      body: BlocProvider(
        create: (context) => WithdrawalBloc(
          createWithdrawalRequest: getIt<CreateWithdrawalRequest>(),
        ),
        child: WithdrawalForm(),
      ),
    );
    //  Scaffold(
    //   appBar: AppBar(
    //     title: Text('Withdraw Funds'),
    //     backgroundColor: Color.fromARGB(255, 93, 204, 68),
    //   ),
    //   body:
    // BlocProvider(
    //     create: (context) => WithdrawalBloc(
    //       createWithdrawalRequest: getIt<CreateWithdrawalRequest>(),
    //     ),
    //     child: WithdrawForm(),
    //   ),
    // );
  }
}
