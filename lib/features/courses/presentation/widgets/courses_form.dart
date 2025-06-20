import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/constants/app_size.dart';
import 'package:project2/core/constants/colors.dart';
import 'package:project2/features/courses/presentation/bloc/courses_bloc/courses_bloc.dart';

import '../../../../dependencies.dart';
import '../bloc/course_schedule_bloc/course_schedule_bloc.dart';
import '../pages/course_details_page.dart';

class CoursesForm extends StatelessWidget {
  const CoursesForm({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppSizes.screenWidth(context) * 0.04;

    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        if (state is CoursesInitial || state is CoursesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CoursesError) {
          return Center(child: Text(state.message));
        } else if (state is CoursesEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search_off,
                  size: 60,
                  color: AppColors.mainColor,
                ),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          );
        } else if (state is CoursesLoaded) {
          // print(state.courses[0].wishlisted);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSizes.screenHeight(context) * 0.02),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.courses.length,
                    itemBuilder: (context, index) {
                      final course = state.courses[index];
                      final iconSize = AppSizes.screenWidth(context) * 0.06;
                      final containerSize =
                          AppSizes.screenWidth(context) * 0.12;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (_) => getIt<CourseScheduleBloc>(),
                                child: CourseDetailsPage(
                                  courseId: course.id,
                                  courseTitle: course.title,
                                  courseDesc: course.description,
                                  coursePrice: course.price,
                                  courseDuration: course.duration,
                                  maxStudent: course.maxStudents,
                                  certificationEligible:
                                      course.certificationEligible,
                                  isWishlisted: course.wishlisted,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: AppSizes.screenHeight(context) * 0.01,
                            bottom: AppSizes.screenHeight(context) * 0.01,
                            right: AppSizes.screenWidth(context) * 0.02,
                          ),
                          child: Stack(
                            children: [
                              // Card content
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 1,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: padding,
                                    vertical:
                                        AppSizes.screenHeight(context) * 0.015,
                                  ),
                                  child: Row(
                                    children: [
                                      // Leading icon container
                                      Container(
                                        width: containerSize,
                                        height: containerSize,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: const Color.fromARGB(
                                              255, 247, 222, 224),
                                        ),
                                      ),
                                      SizedBox(
                                          width: AppSizes.screenWidth(context) *
                                              0.04),

                                      // Course info column
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              course.title,
                                              style: TextStyle(
                                                fontSize: AppSizes.screenWidth(
                                                        context) *
                                                    0.04,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.greyColor,
                                              ),
                                            ),
                                            SizedBox(
                                                height: AppSizes.screenHeight(
                                                        context) *
                                                    0.005),
                                            Text(
                                              'Hours: ${course.duration}h',
                                              style: TextStyle(
                                                fontSize: AppSizes.screenWidth(
                                                        context) *
                                                    0.035,
                                                color: AppColors.mainColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Price column
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                              height: AppSizes.screenHeight(
                                                      context) *
                                                  0.04),
                                          Text(
                                            'Price: ${course.price}\$',
                                            style: TextStyle(
                                              fontSize: AppSizes.screenWidth(
                                                      context) *
                                                  0.035,
                                              color: AppColors.mainColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Spacer for the arrow that will be positioned outside
                                      SizedBox(
                                          width: AppSizes.screenWidth(context) *
                                              0.1),
                                    ],
                                  ),
                                ),
                              ),

                              // Arrow container positioned outside the card
                              Positioned(
                                right: -1,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: Container(
                                    width:
                                        AppSizes.screenWidth(context) * 0.091,
                                    height:
                                        AppSizes.screenHeight(context) * 0.045,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color.fromARGB(
                                          255, 247, 222, 224),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: iconSize * 0.8,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
