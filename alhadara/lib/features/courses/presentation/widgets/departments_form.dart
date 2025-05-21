// // lib/features/courses/presentation/widgets/departments_form.dart

import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/core/constants/no_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alhadara/features/courses/presentation/pages/course_types_page.dart';
import '../../../../core/constants/app_size.dart';
import '../bloc/department_bloc/departments_bloc.dart';

class DepartmentsForm extends StatelessWidget {
  const DepartmentsForm({super.key});

  IconData _getDepartmentIcon(String departmentName) {
    switch (departmentName.toLowerCase()) {
      case 'design':
        return Icons.design_services;
      case 'computers':
        return Icons.computer;
      case 'charter':
        return Icons.assignment;
      case 'cooks':
        return Icons.restaurant;
      case 'hotel booking':
        return Icons.hotel;
      default:
        return Icons.school;
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = AppSizes.screenWidth(context) * 0.04; // 4% of screen width

    return BlocBuilder<DepartmentsBloc, DepartmentsState>(
      builder: (context, state) {
        if (state is DepartmentsInitial || state is DepartmentsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DepartmentsError) {
          return NoItemWidget(
            message: state.message,
            icon: Icons.error_outline,
            iconColor: Colors.red,
          );
        } else if (state is DepartmentsEmpty) {
          return NoItemWidget(
            message: state.message,
            icon: Icons.search_off,
          );
        } else if (state is DepartmentsLoaded) {
          // print(state.departments);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSizes.screenHeight(context) * 0.02),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.departments.length,
                    itemBuilder: (context, index) {
                      final department = state.departments[index];
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
                            child: Icon(
                              _getDepartmentIcon(department.name),
                              size: iconSize,
                              color:AppColors.mainColor,
                            ),
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
                            department.name,
                            style: TextStyle(
                              fontSize: AppSizes.screenWidth(context) * 0.045,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            department.description,
                            style: TextStyle(
                              fontSize: AppSizes.screenWidth(context) * 0.035,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseTypesPage(
                                  departmentId: department
                                      .id, // Pass the actual department ID here
                                ),
                              ),
                            );
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
