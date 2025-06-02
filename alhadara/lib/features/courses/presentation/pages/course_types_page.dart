import 'package:alhadara/core/constants/app_back_button.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/core/constants/notification_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/courses/presentation/bloc/course_types_bloc/course_types_bloc.dart';
import 'package:alhadara/features/courses/presentation/widgets/course_types_form.dart';

class CourseTypesPage extends StatelessWidget {
  final int departmentId; // Add departmentId parameter
  const CourseTypesPage({super.key,required this.departmentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CourseTypesBloc>()..add(LoadCourseTypes(departmentId)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight:
          AppSizes.screenHeight(context) * 0.09, // 9% of screen height
          backgroundColor: Colors.white,
          shadowColor: const Color.fromARGB(157, 244, 248, 251),
          leading: Padding(
            padding:
            EdgeInsets.only(left: AppSizes.screenWidth(context) * 0.03),
            child: AppBackButton()
          ),
          title: const Text(
            'Course Types',
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
        body: const CourseTypesForm(),
      ),
    );
  }
}