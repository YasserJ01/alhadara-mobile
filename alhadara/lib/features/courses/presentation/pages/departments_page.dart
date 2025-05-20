import 'package:alhadara/core/constants/app_back_button.dart';
import 'package:alhadara/core/constants/colors.dart';
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: AppColors.mainColor,
                      size: AppSizes.screenWidth(context) * 0.09,
                    ),
                    onPressed: () {
                      // Handle notification button press
                    },
                  ),
                  Positioned(
                    right: AppSizes.screenWidth(context) * 0,
                    top: AppSizes.screenHeight(context) * 0.01,
                    child: Container(
                      padding:
                          EdgeInsets.all(AppSizes.screenWidth(context) * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: AppSizes.screenWidth(context) * 0.055,
                        minHeight: AppSizes.screenHeight(context) * 0,
                      ),
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.screenWidth(context) * 0.03,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        body: const DepartmentsForm(),
      ),
    );
  }
}