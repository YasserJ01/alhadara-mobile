import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../dependencies.dart';
import '../bloc/deposit_request/deposit_request_bloc.dart';
import '../widgets/deposit_request_view.dart';

class DepositRequestPage extends StatelessWidget {
  final int depositMethodId;

  const DepositRequestPage({
    Key? key,
    required this.depositMethodId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DepositRequestBloc>(),
      // Add this to your dependencies
      child: DepositRequestView(depositMethodId: depositMethodId),
    );
  }
}
