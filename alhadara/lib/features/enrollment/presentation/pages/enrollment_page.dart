import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_scaffold.dart';
import '../../../../core/constants/colors.dart';
import '../../../../dependencies.dart';
import '../bloc/enrollments/enrollment_bloc.dart';
import '../widgets/enrollment_list.dart';

class EnrollmentsPage extends StatelessWidget {
  const EnrollmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(
        decoration: const BoxDecoration(
            // gradient: LinearGradient(
            color: AppColors.whiteColor
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [Colors.deepPurple, Colors.indigo],
            // ),
            ),
        child: BlocProvider(
          create: (context) => getIt<EnrollmentBloc>()..add(FetchEnrollments()),
          child: const EnrollmentsView(),
        ),
      ),
      title: 'Enrollments',
      edgeInsets: const EdgeInsets.all(0),
    );
  }
}
