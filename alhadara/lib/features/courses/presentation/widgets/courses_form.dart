
import 'package:alhadara/core/constants/no_item.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/courses/presentation/bloc/course_schedule_bloc/course_schedule_bloc.dart';
import 'package:alhadara/features/courses/presentation/pages/course_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/features/courses/presentation/bloc/courses_bloc/courses_bloc.dart';

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
                      final imageWidth = AppSizes.screenWidth(context) * 0.29;
                      final cardHeight = AppSizes.screenHeight(context) * 0.13;

                      return Padding(
                        padding: EdgeInsets.only(
                          top: AppSizes.screenHeight(context) * 0.008,
                          bottom: AppSizes.screenHeight(context) * 0.008,
                        ),
                        child: Stack(
                          clipBehavior:
                              Clip.none, // Allows elements to overflow
                          children: [
                            // Main Card
                            InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (_) =>
                                          getIt<CourseScheduleBloc>(),
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
                                         hasDiscount: course.hasDiscount, // أضف هذا
      discountInfo: course.discountInfo, // أضف هذا
      originalPrice: course.originalPrice, 
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                                margin: EdgeInsets.only(
                                    right: padding * 0.5), // Space for arrow
                                child: Container(
                                  height: cardHeight,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      // Image section
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        ),
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
                                      // Content section
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: padding * 0.8,
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
                                                  fontSize:
                                                      AppSizes.screenWidth(
                                                              context) *
                                                          0.039,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey[800],
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
                                                  Icon(
                                                    Icons.timer_outlined,
                                                    size: iconSize * 0.6,
                                                    color: AppColors.mainColor,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    '${course.duration}h',
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSizes.screenWidth(
                                                                  context) *
                                                              0.035,
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  ),
                                                  SizedBox(width: 30),
                                                  Icon(
                                                    Icons.attach_money,
                                                    size: iconSize * 0.6,
                                                    color: AppColors.mainColor,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    '${course.price}',
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSizes.screenWidth(
                                                                  context) *
                                                              0.035,
                                                      color:
                                                          AppColors.mainColor,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                            ),

                            // Floating arrow button positioned outside the card
                            Positioned(
                              right: -15,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: Container(
                                  width: AppSizes.screenWidth(context) * 0.1,
                                  height: AppSizes.screenWidth(context) * 0.1,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        spreadRadius: 3,
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider(
                                            create: (_) =>
                                                getIt<CourseScheduleBloc>(),
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
                                               hasDiscount: course.hasDiscount, // أضف هذا
      discountInfo: course.discountInfo, // أضف هذا
      originalPrice: course.originalPrice, 
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: iconSize * 0.7,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
