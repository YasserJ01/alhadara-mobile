// features/courses/presentation/pages/course_category_page.dart
import 'package:flutter/material.dart';
import 'package:alhadara/core/constants/app_back_button.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/features/courses/presentation/pages/courses_page.dart';

class CourseCategoryPage extends StatelessWidget {
  final int departmentId;
  final int courseTypeId;
  final String courseTypeName;

  const CourseCategoryPage({
    super.key,
    required this.departmentId,
    required this.courseTypeId,
    required this.courseTypeName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: AppSizes.screenHeight(context) * 0.09,
        backgroundColor: Colors.white,
        shadowColor: const Color.fromARGB(157, 244, 248, 251),
        leading: Padding(
          padding: EdgeInsets.only(left: AppSizes.screenWidth(context) * 0.03),
          child: AppBackButton(),
        ),
        title: Text(
          courseTypeName,
          style: const TextStyle(
            color: AppColors.mainColor,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSizes.screenWidth(context) * 0.03),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: AppColors.mainColor,
                    size: AppSizes.screenWidth(context) * 0.09,
                  ),
                  onPressed: () {},
                ),
                Positioned(
                  right: AppSizes.screenWidth(context) * 0,
                  top: AppSizes.screenHeight(context) * 0.01,
                  child: Container(
                    padding: EdgeInsets.all(AppSizes.screenWidth(context) * 0.01),
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
      body: Padding(
        padding: EdgeInsets.all(AppSizes.screenWidth(context) * 0.04),
        child: Column(
          children: [
            _buildCategoryTile(
              context,
              title: 'Workshops',
              icon: Icons.work_outline,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoursesPage(
                      departmentId: departmentId,
                      courseTypeId: courseTypeId,
                      category: 'workshop',
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: AppSizes.screenHeight(context) * 0.02),
            _buildCategoryTile(
              context,
              title: 'Courses',
              icon: Icons.school_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoursesPage(
                      departmentId: departmentId,
                      courseTypeId: courseTypeId,
                      category: 'course',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final iconSize = AppSizes.screenWidth(context) * 0.06;
    final containerSize = AppSizes.screenWidth(context) * 0.12;

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
          horizontal: AppSizes.screenWidth(context) * 0.04,
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
            icon,
            size: iconSize,
            color: AppColors.mainColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: AppSizes.screenWidth(context) * 0.045,
            fontWeight: FontWeight.w500,
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
        onTap: onTap,
      ),
    );
  }
}