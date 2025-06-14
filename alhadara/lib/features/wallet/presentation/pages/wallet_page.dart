import 'package:alhadara/core/constants/app_back_button.dart';
import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/pages/new/bank_selection_page.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/pages/new/method_selection_page.dart';
import 'package:alhadara/features/wallet/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:alhadara/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:alhadara/features/wallet/presentation/pages/withdraw_page.dart';
import 'package:alhadara/features/wallet/presentation/widgets/transaction_item.dart';
import 'package:alhadara/features/wallet/presentation/widgets/wallet_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => getIt<WalletBloc>()..add(LoadWalletEvent())),
          BlocProvider(
            create: (context) =>
                getIt<TransactionBloc>()..add(LoadTransactionsEvent()),
          )
        ],
        child: AppScaffold(
          edgeInsets: EdgeInsets.all(0),
          title: 'Wallet',
          textColor: AppColors.whiteColor,
          backIconColor: AppColors.whiteColor,
          backgroundColor: AppColors.mainColor,
          body: WalletForm(),
        ));
  }
}
