import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/constants/app_size.dart';
import 'package:project2/core/constants/colors.dart';
import 'package:project2/features/courses/presentation/bloc/courses_bloc/courses_bloc.dart';

import '../../../../core/constants/no_item.dart';
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
          return NoItemWidget(
            message: state.message,
            icon: Icons.error_outline,
            iconColor: Colors.red,
          );
        } else if (state is CoursesEmpty) {
          return NoItemWidget(
            message: state.message,
            icon: Icons.search_off,
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
                      final imageWidth = AppSizes.screenWidth(context) *
                          0.29; // Reduced from 0.3
                      final cardHeight = AppSizes.screenHeight(context) *
                          0.13; // Reduced from 0.15

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
                                  requiredLanguage: course.requiredLanguage,
                                  requiredLanguageName: course.requiredLanguageName,
                                  requiredLanguageLevel: course.requiredLanguageLevel,
                                  requiredLanguageLevelDisplay: course.requiredLanguageLevelDisplay,
                                  canEnroll: course.canEnroll,
                                  languageMessage: course.languageMessage,
                                  hasDiscount: course.hasDiscount,
                                  discountInfo: course.discountInfo,
                                  originalPrice: course.originalPrice,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: AppSizes.screenHeight(context) *
                                0.008, // Reduced padding
                            bottom: AppSizes.screenHeight(context) * 0.008,
                            right: AppSizes.screenWidth(context) * 0.02,
                          ),
                          child: Stack(
                            children: [
                              // Card content
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Slightly smaller radius
                                ),
                                elevation: 1,
                                margin: EdgeInsets.zero,
                                // Remove default margin
                                child: SizedBox(
                                  height: cardHeight,
                                  child: Row(
                                    children: [
                                      // Image filling the left portion
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          'assets/yass.jpg',
                                          width: imageWidth,
                                          height: cardHeight,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              width: imageWidth,
                                              color: const Color.fromARGB(
                                                  255, 247, 222, 224),
                                              child: Icon(
                                                Icons.school,
                                                color: AppColors.mainColor,
                                                size: iconSize,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      // Content area
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: padding *
                                                0.8, // Slightly reduced padding
                                            vertical:
                                                AppSizes.screenHeight(context) *
                                                    0.01,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                course.title,
                                                style: TextStyle(
                                                  fontSize: AppSizes
                                                          .screenWidth(
                                                              context) *
                                                      0.039, // Slightly smaller
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.greyColor,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                  height: AppSizes.screenHeight(
                                                          context) *
                                                      0.01),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${course.duration}h',
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSizes.screenWidth(
                                                                  context) *
                                                              0.035,
                                                      // Slightly smaller
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          AppSizes.screenWidth(
                                                                  context) *
                                                              0.15),
                                                  Text(
                                                    '${course.price}\$',
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSizes.screenWidth(
                                                                  context) *
                                                              0.035,
                                                      color:
                                                          AppColors.mainColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Arrow button
                              Positioned(
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: Container(
                                    width: AppSizes.screenWidth(context) *
                                        0.08, // Slightly smaller
                                    height:
                                        AppSizes.screenHeight(context) * 0.04,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: iconSize * 0.7, // Slightly smaller
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
