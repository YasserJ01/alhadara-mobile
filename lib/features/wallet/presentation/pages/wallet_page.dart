import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/l10n/generated/app_localizations.dart';

import '../../../../core/constants/app_scaffold.dart';
import '../../../../core/constants/colors.dart';
import '../../../../dependencies.dart';
import '../bloc/transaction_bloc/transaction_bloc.dart';
import '../bloc/wallet_bloc.dart';
import '../widgets/wallet_form.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => getIt<WalletBloc>()..add(LoadWalletEvent())),
          BlocProvider(
            create: (context) =>
                getIt<TransactionBloc>()..add(LoadTransactionsEvent()),
          )
        ],
        child:  AppScaffold(
          edgeInsets: const EdgeInsets.all(0),
          title: l10n.wallet,
          // textColor: AppColors.whiteColor,
          // backIconColor: AppColors.whiteColor,
          // backgroundColor: AppColors.mainColor,
          body: WalletForm(),
        ));
  }
}
