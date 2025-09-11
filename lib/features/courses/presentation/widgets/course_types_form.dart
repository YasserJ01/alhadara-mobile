import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/constants/app_size.dart';
import 'package:project2/features/courses/presentation/bloc/course_types_bloc/course_types_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../dependencies.dart';
import '../bloc/courses_bloc/courses_bloc.dart';
import '../pages/choosing_course_category_screen.dart';
import '../pages/courses_page.dart';


class CourseTypesForm extends StatelessWidget {
  const CourseTypesForm({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppSizes.screenWidth(context) * 0.04;

    return BlocBuilder<CourseTypesBloc, CourseTypesState>(
      builder: (context, state) {
        if (state is CourseTypesInitial || state is CourseTypesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CourseTypesError) {
          return Center(child: Text(state.message));
        } else if (state is CourseTypesEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search_off,
                size: 60,
                color: Color.fromRGBO(162, 12, 13, 1.0),
              ),
              const SizedBox(height: 16),
              Text(
                state.message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ],
          );
        } else if (state is CourseTypesLoaded) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSizes.screenHeight(context) * 0.02),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.courseTypes.length,
                    itemBuilder: (context, index) {
                      final courseType = state.courseTypes[index];
                      return _buildCourseTypeCard(context, courseType, padding);
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCourseTypeCard(BuildContext context, courseType, double padding) {
    final iconSize = AppSizes.screenWidth(context) * 0.06;
    final containerSize = AppSizes.screenWidth(context) * 0.12;

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: AppSizes.screenHeight(context) * 0.01,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Column(
        children: [
          // Course Type Header
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: AppSizes.screenHeight(context) * 0.015,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 247, 222, 224).withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: containerSize,
                  height: containerSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromARGB(255, 247, 222, 224),
                  ),
                  child: Icon(
                    Icons.school,
                    size: iconSize,
                    color: const Color.fromRGBO(162, 12, 13, 1.0),
                  ),
                ),
                SizedBox(width: AppSizes.screenWidth(context) * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseType.name,
                        style: TextStyle(
                          fontSize: AppSizes.screenWidth(context) * 0.045,
                          fontWeight: FontWeight.w600,
                          color: AppColors.mainColor,
                        ),
                      ),
                      Text(
                        courseType.department_name,
                        style: TextStyle(
                          fontSize: AppSizes.screenWidth(context) * 0.035,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Category Options
          Padding(
            padding: EdgeInsets.all(padding * 0.5),
            child: Row(
              children: [
                Expanded(
                  child: _buildCategoryButton(
                    context,
                    title: 'Workshops',
                    icon: Icons.work_outline,
                    onTap: () => _navigateToCoursesPage(
                      context,
                      courseType.department,
                      courseType.id,
                      'workshop',
                    ),
                  ),
                ),
                SizedBox(width: AppSizes.screenWidth(context) * 0.02),
                Expanded(
                  child: _buildCategoryButton(
                    context,
                    title: 'Courses',
                    icon: Icons.school_outlined,
                    onTap: () => _navigateToCoursesPage(
                      context,
                      courseType.department,
                      courseType.id,
                      'course',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
      BuildContext context, {
        required String title,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.screenHeight(context) * 0.015,
            horizontal: AppSizes.screenWidth(context) * 0.02, // Reduced horizontal padding
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.mainColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Add this
            children: [
              Icon(
                icon,
                size: AppSizes.screenWidth(context) * 0.045, // Slightly smaller
                color: AppColors.mainColor,
              ),
              SizedBox(width: AppSizes.screenWidth(context) * 0.015), // Reduced spacing
              Flexible( // Wrap text in Flexible
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: AppSizes.screenWidth(context) * 0.035, // Smaller font
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainColor,
                  ),
                  overflow: TextOverflow.ellipsis, // Add overflow handling
                  maxLines: 1,
                ),
              ),
              SizedBox(width: AppSizes.screenWidth(context) * 0.01),
              Icon(
                Icons.arrow_forward_ios,
                size: AppSizes.screenWidth(context) * 0.03, // Smaller arrow
                color: AppColors.mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCoursesPage(
      BuildContext context,
      int departmentId,
      int courseTypeId,
      String category,
      ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<CoursesBloc>()
            ..add(LoadCourses(
              department: departmentId,
              courseType: courseTypeId,
              category: category,
            )),
          child: CoursesPage(
            departmentId: departmentId,
            courseTypeId: courseTypeId,
            category: category,
          ),
        ),
      ),
    );
  }
}