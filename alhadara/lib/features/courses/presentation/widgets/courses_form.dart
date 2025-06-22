// // import 'package:alhadara/core/constants/no_item.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:alhadara/core/constants/app_size.dart';
// // import 'package:alhadara/core/constants/colors.dart';
// // import 'package:alhadara/features/courses/presentation/bloc/courses_bloc/courses_bloc.dart';

// // class CoursesForm extends StatelessWidget {
// //   const CoursesForm({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final padding = AppSizes.screenWidth(context) * 0.04;

// //     return BlocBuilder<CoursesBloc, CoursesState>(
// //       builder: (context, state) {
// //         if (state is CoursesInitial || state is CoursesLoading) {
// //           return const Center(child: CircularProgressIndicator());
// //         } else if (state is CoursesError) {
// //           return NoItemWidget(
// //             message: state.message,
// //             icon: Icons.error_outline,
// //             iconColor: Colors.red,
// //           );
// //         } else if (state is CoursesEmpty) {
// //           return NoItemWidget(
// //             message: state.message,
// //             icon: Icons.search_off,
// //           );
// //         } else if (state is CoursesLoaded) {
// //           return Padding(
// //             padding: EdgeInsets.symmetric(horizontal: padding),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 SizedBox(height: AppSizes.screenHeight(context) * 0.02),
// //                 Expanded(
// //                   child: ListView.builder(
// //                     itemCount: state.courses.length,
// //                     itemBuilder: (context, index) {
// //                       final course = state.courses[index];
// //                       final iconSize = AppSizes.screenWidth(context) * 0.06;
// //                       final containerSize =
// //                           AppSizes.screenWidth(context) * 0.12;

// //                       return Padding(
// //                         padding: EdgeInsets.only(
// //                           top: AppSizes.screenHeight(context) * 0.01,
// //                           bottom: AppSizes.screenHeight(context) * 0.01,
// //                           right: AppSizes.screenWidth(context) * 0.02,
// //                         ),
// //                         child: Stack(
// //                           children: [
// //                             // Card content
// //                             Card(
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(12),
// //                               ),
// //                               elevation: 1,
// //                               child: Container(
// //                                 padding: EdgeInsets.symmetric(
// //                                   horizontal: padding,
// //                                   vertical:
// //                                       AppSizes.screenHeight(context) * 0.015,
// //                                 ),
// //                                 child: Row(
// //                                   children: [
// //                                     // Leading icon container
// //                                     Container(
// //                                       width: containerSize,
// //                                       height: containerSize,
// //                                       decoration: BoxDecoration(
// //                                         borderRadius:
// //                                             BorderRadius.circular(100),
// //                                         color: const Color.fromARGB(
// //                                             255, 247, 222, 224),
// //                                       ),
// //                                     ),
// //                                     SizedBox(
// //                                         width: AppSizes.screenWidth(context) *
// //                                             0.04),

// //                                     // Course info column
// //                                     Expanded(
// //                                       child: Column(
// //                                         crossAxisAlignment:
// //                                             CrossAxisAlignment.start,
// //                                         children: [
// //                                           Text(
// //                                             course.title,
// //                                             style: TextStyle(
// //                                               fontSize: AppSizes.screenWidth(
// //                                                       context) *
// //                                                   0.04,
// //                                               fontWeight: FontWeight.w500,
// //                                               color: AppColors.greyColor,
// //                                             ),
// //                                           ),
// //                                           SizedBox(
// //                                               height: AppSizes.screenHeight(
// //                                                       context) *
// //                                                   0.005),
// //                                           Text(
// //                                             'Hours: ${course.duration}h',
// //                                             style: TextStyle(
// //                                               fontSize: AppSizes.screenWidth(
// //                                                       context) *
// //                                                   0.035,
// //                                               color: AppColors.mainColor,
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ),

// //                                     // Price column
// //                                     Column(
// //                                       crossAxisAlignment:
// //                                           CrossAxisAlignment.end,
// //                                       children: [
// //                                         SizedBox(
// //                                             height:
// //                                                 AppSizes.screenHeight(context) *
// //                                                     0.04),
// //                                         Text(
// //                                           'Price: ${course.price}\$',
// //                                           style: TextStyle(
// //                                             fontSize:
// //                                                 AppSizes.screenWidth(context) *
// //                                                     0.035,
// //                                             color: AppColors.mainColor,
// //                                             fontWeight: FontWeight.w500,
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),

// //                                     // Spacer for the arrow that will be positioned outside
// //                                     SizedBox(
// //                                         width: AppSizes.screenWidth(context) *
// //                                             0.1),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),

// //                             // Arrow container positioned outside the card
// //                             Positioned(
// //                               right: 0,
// //                               top: 0,
// //                               bottom: 0,
// //                               child: Center(
// //                                 child: Container(
// //                                   width: AppSizes.screenWidth(context) * 0.091,
// //                                   height:
// //                                       AppSizes.screenHeight(context) * 0.045,
// //                                   decoration: BoxDecoration(
// //                                     borderRadius: BorderRadius.circular(100),
// //                                     color: Colors.white,
// //                                     boxShadow: [
// //                                       BoxShadow(
// //                                         color: Colors.black.withOpacity(0.2),
// //                                         spreadRadius: 1,
// //                                         blurRadius: 3,
// //                                         offset: const Offset(
// //                                             0, 2), // changes position of shadow
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   child: Icon(
// //                                     Icons.arrow_forward_ios,
// //                                     size: iconSize * 0.8,
// //                                     color: AppColors.mainColor,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //         }
// //         return const SizedBox.shrink();
// //       },
// //     );
// //   }
// // }
// import 'package:alhadara/core/constants/no_item.dart';
// import 'package:alhadara/dependencies.dart';
// import 'package:alhadara/features/courses/presentation/bloc/course_schedule_bloc/course_schedule_bloc.dart';
// import 'package:alhadara/features/courses/presentation/pages/course_details_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:alhadara/core/constants/app_size.dart';
// import 'package:alhadara/core/constants/colors.dart';
// import 'package:alhadara/features/courses/presentation/bloc/courses_bloc/courses_bloc.dart';

// // ... (previous imports remain the same)

// // ... (previous imports remain the same)

// class CoursesForm extends StatelessWidget {
//   const CoursesForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final padding = AppSizes.screenWidth(context) * 0.04;

//     return BlocBuilder<CoursesBloc, CoursesState>(
//       builder: (context, state) {
//         if (state is CoursesInitial || state is CoursesLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is CoursesError) {
//           return NoItemWidget(
//             message: state.message,
//             icon: Icons.error_outline,
//             iconColor: Colors.red,
//           );
//         } else if (state is CoursesEmpty) {
//           return NoItemWidget(
//             message: state.message,
//             icon: Icons.search_off,
//           );
//         } else if (state is CoursesLoaded) {
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: padding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.02),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: state.courses.length,
//                     itemBuilder: (context, index) {
//                       final course = state.courses[index];
//                       final iconSize = AppSizes.screenWidth(context) * 0.06;
//                       final imageWidth = AppSizes.screenWidth(context) *
//                           0.29; // Reduced from 0.3
//                       final cardHeight = AppSizes.screenHeight(context) *
//                           0.13; // Reduced from 0.15

//                       return Padding(
//                         padding: EdgeInsets.only(
//                           top: AppSizes.screenHeight(context) *
//                               0.008, // Reduced padding
//                           bottom: AppSizes.screenHeight(context) * 0.008,
//                           right: AppSizes.screenWidth(context) * 0.02,
//                         ),
//                         child: Stack(
//                           children: [
//                             // Card content
//                             Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(
//                                     10), // Slightly smaller radius
//                               ),
//                               elevation: 8,
//                               shadowColor: const Color.fromARGB(255, 63, 62, 62)
//                                   .withOpacity(0.1),
//                               margin: EdgeInsets.zero, // Remove default margin
//                               child: SizedBox(
//                                 height: cardHeight,
//                                 child: Row(
//                                   children: [
//                                     // Image filling the left portion
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(10),
//                                       child: Image.asset(
//                                         'assets/yass.jpg',
//                                         width: imageWidth,
//                                         height: cardHeight,
//                                         fit: BoxFit.cover,
//                                         errorBuilder:
//                                             (context, error, stackTrace) {
//                                           return Container(
//                                             width: imageWidth,
//                                             color: const Color.fromARGB(
//                                                 255, 247, 222, 224),
//                                             child: Icon(
//                                               Icons.school,
//                                               color: AppColors.mainColor,
//                                               size: iconSize,
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                     // Content area
//                                     Expanded(
//                                       child: Padding(
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: padding *
//                                               0.8, // Slightly reduced padding
//                                           vertical:
//                                               AppSizes.screenHeight(context) *
//                                                   0.01,
//                                         ),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               course.title,
//                                               style: TextStyle(
//                                                 fontSize: AppSizes.screenWidth(
//                                                         context) *
//                                                     0.039, // Slightly smaller
//                                                 fontWeight: FontWeight.w500,
//                                                 color: AppColors.greyColor,
//                                               ),
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                             SizedBox(
//                                                 height: AppSizes.screenHeight(
//                                                         context) *
//                                                     0.01),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   '${course.duration}h',
//                                                   style: TextStyle(
//                                                     fontSize: AppSizes
//                                                             .screenWidth(
//                                                                 context) *
//                                                         0.035, // Slightly smaller
//                                                     color: AppColors.mainColor,
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                     width: AppSizes.screenWidth(
//                                                             context) *
//                                                         0.15),
//                                                 Text(
//                                                   '${course.price}\$',
//                                                   style: TextStyle(
//                                                     fontSize:
//                                                         AppSizes.screenWidth(
//                                                                 context) *
//                                                             0.035,
//                                                     color: AppColors.mainColor,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             // Arrow button
//                             Positioned(
//                               right: -3,
//                               top: 0,
//                               bottom: 10,
//                               child: Center(
//                                 child: Container(
//                                   width: AppSizes.screenWidth(context) *
//                                       0.08, // Slightly smaller
//                                   height: AppSizes.screenHeight(context) * 0.04,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(100),
//                                     color: Colors.white,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.2),
//                                         spreadRadius: 1,
//                                         blurRadius: 3,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: IconButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (_) => BlocProvider(
//                                             create: (_) =>
//                                                 getIt<CourseScheduleBloc>(),
//                                             child: CourseDetailsPage(
//                                               courseId: course.id,
//                                               courseTitle: course.title,
//                                               courseDesc: course.description,
//                                               coursePrice: course.price,
//                                               courseDuration: course.duration,
//                                               maxStudent: course.maxStudents,
//                                               certificationEligible:
//                                                   course.certificationEligible,
//                                               isWishlisted: course.wishlisted,
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     icon: Icon(Icons.arrow_forward_ios),
//                                     iconSize: iconSize * 0.7,
//                                     // Slightly smaller
//                                     color: AppColors.mainColor,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
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
