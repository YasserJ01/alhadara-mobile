// features/courses/presentation/pages/courses_page.dart
import 'package:alhadara/core/constants/notification_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alhadara/core/constants/app_back_button.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/courses/presentation/bloc/courses_bloc/courses_bloc.dart';
import 'package:alhadara/features/courses/presentation/widgets/courses_form.dart';

class CoursesPage extends StatelessWidget {
  final int departmentId;
  final int courseTypeId;
  final String category;

  const CoursesPage({
    super.key,
    required this.departmentId,
    required this.courseTypeId,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CoursesBloc>()
        ..add(LoadCourses(
          department: departmentId,
          courseType: courseTypeId,
          category: category,
        )),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: AppSizes.screenHeight(context) * 0.09,
          backgroundColor: Colors.white,
          shadowColor: const Color.fromARGB(157, 244, 248, 251),
          leading: Padding(
            padding:
                EdgeInsets.only(left: AppSizes.screenWidth(context) * 0.03),
            child: AppBackButton(),
          ),
          title: const Text(
            'Courses',
            style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
                padding: EdgeInsets.only(
                    right: AppSizes.screenWidth(context) * 0.03),
                child: NotificationBadge(count: 3,)),
          ],
        ),
        body: const CoursesForm(),
      ),
    );
  }
}
