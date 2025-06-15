import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/enrollments/presentation/bloc/enrollment_bloc.dart';
import 'package:alhadara/features/enrollments/presentation/widgets/enrollment_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      edgeInsets: EdgeInsets.all(0),
    );
  }
}
