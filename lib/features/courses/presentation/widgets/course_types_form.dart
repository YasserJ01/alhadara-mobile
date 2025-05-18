import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/constants/app_size.dart';
import 'package:project2/features/courses/presentation/bloc/course_types_bloc/course_types_bloc.dart';

class CourseTypesForm extends StatelessWidget {
  const CourseTypesForm({super.key});

  // IconData _getCourseTypesIcon(String departmentName) {
  //   switch (courseName.toLowerCase()) {
  //     case 'design':
  //       return Icons.design_services;
  //     case 'computers':
  //       return Icons.computer;
  //     case 'charter':
  //       return Icons.assignment;
  //     case 'cooks':
  //       return Icons.restaurant;
  //     case 'hotel booking':
  //       return Icons.hotel;
  //     default:
  //       return Icons.school;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final padding = AppSizes.screenWidth(context) * 0.04; // 4% of screen width

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
          // print(state.departments);
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
                      final courseTypes = state.courseTypes[index];
                      final iconSize = AppSizes.screenWidth(context) * 0.06;
                      final containerSize =
                          AppSizes.screenWidth(context) * 0.12;
                      return Card(
                        margin: EdgeInsets.symmetric(
                          vertical: AppSizes.screenHeight(context) * 0.01,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 1,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: padding,
                            vertical: AppSizes.screenHeight(context) * 0.01,
                          ),
                          leading: Container(
                            width: containerSize,
                            height: containerSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color.fromARGB(255, 247, 222, 224),
                            ),
                            // child: Icon(
                            //   _getDepartmentIcon(department.name),
                            //   size: iconSize,
                            //   color: const Color.fromRGBO(162, 12, 13, 1.0),
                            // ),
                          ),
                          trailing: Container(
                            width: containerSize,
                            height: containerSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey.shade200,
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: iconSize,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          title: Text(
                            courseTypes.name,
                            style: TextStyle(
                              fontSize: AppSizes.screenWidth(context) * 0.045,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            courseTypes.department_name,
                            style: TextStyle(
                              fontSize: AppSizes.screenWidth(context) * 0.035,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            // Navigate to department detail or courses in this department
                          },
                        ),
                      );
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
}
