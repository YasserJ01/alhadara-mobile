import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/courses/presentation/bloc/department_bloc/departments_bloc.dart';
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
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                size:
                    AppSizes.screenWidth(context) * 0.08, // 8% of screen width
                color: const Color.fromRGBO(162, 12, 13, 1.0),
              ),
            ),
          ),
          title: const Text(
            'Departments',
            style: TextStyle(
              color: Color.fromRGBO(162, 12, 13, 1.0),
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
                      color: const Color.fromRGBO(162, 12, 13, 1.0),
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