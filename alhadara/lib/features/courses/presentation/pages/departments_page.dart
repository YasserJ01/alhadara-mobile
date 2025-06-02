import 'package:alhadara/core/constants/app_back_button.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/core/constants/notification_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alhadara/features/courses/presentation/bloc/department_bloc/departments_bloc.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../dependencies.dart';

import '../widgets/departments_form.dart';

class DepartmentsPage extends StatelessWidget {
  const DepartmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DepartmentsBloc>()..add(LoadDepartments()),
      child: Scaffold(
        backgroundColor: const Color(0xffF4F8FB),
        appBar: AppBar(
          toolbarHeight:
              AppSizes.screenHeight(context) * 0.09, // 9% of screen height
          backgroundColor: Colors.white,
          shadowColor: const Color.fromARGB(157, 244, 248, 251),
          leading: Padding(
            padding:
                EdgeInsets.only(left: AppSizes.screenWidth(context) * 0.03),
            child:AppBackButton()
          ),
          title: const Text(
            'Departments',
            style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding:
                  EdgeInsets.only(right: AppSizes.screenWidth(context) * 0.03),
              child: NotificationBadge(count: 3,)
            ),
          ],
        ),
        body: const DepartmentsForm(),
      ),
    );
  }
}