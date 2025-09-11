// pages/loyalty_points_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/constants/app_scaffold.dart';
import '../../../../dependencies.dart';
import '../bloc/loyalty_points_bloc.dart';
import '../bloc/loyalty_points_event.dart';
import '../bloc/loyalty_points_state.dart';
import '../widgets/loyalty_points_widget.dart';

class LoyaltyPointsPage extends StatelessWidget {
  const LoyaltyPointsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Loyalty Points',
      body: BlocProvider(
        create: (context) =>
            getIt<LoyaltyPointsBloc>()..add(GetLoyaltyPointsEvent()),
        child: const LoyaltyPointsWidget(),
      ),
    );
  }
}
