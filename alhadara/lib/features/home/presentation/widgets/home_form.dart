import 'package:alhadara/features/courses/domain/entites/course.dart';
import 'package:alhadara/features/courses/presentation/pages/course_details_page.dart';
import 'package:alhadara/features/courses/presentation/widgets/wishlistButton.dart';
import 'package:alhadara/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/core/constants/no_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeForm extends StatelessWidget {
  const HomeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppSizes.screenWidth(context) * 0.04;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial || state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeError) {
          return NoItemWidget(
            message: state.message,
            icon: Icons.error_outline,
            iconColor: Colors.red,
          );
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                SizedBox(height: AppSizes.screenHeight(context) * 0.02),
                Container(
                  height: AppSizes.screenHeight(context) * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 35,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                // Courses Section
                SizedBox(height: AppSizes.screenHeight(context) * 0.04),
                Text(
                  'Recommendations',
                  style: TextStyle(
                    fontSize: AppSizes.screenWidth(context) * 0.05,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                ),
                SizedBox(height: AppSizes.screenHeight(context) * 0.02),

                // Horizontal Scrollable Courses
                SizedBox(
                  height: AppSizes.screenHeight(context) * 0.2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.recommendedCourses.length,
                    itemBuilder: (context, index) {
                      final course = state.recommendedCourses[index];
                      return _buildCourseCard(context, course);
                    },
                  ),
                ),

                // Offers Section
                SizedBox(height: AppSizes.screenHeight(context) * 0.01),
                Text(
                  'Offers',
                  style: TextStyle(
                    fontSize: AppSizes.screenWidth(context) * 0.05,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                ),
                SizedBox(height: AppSizes.screenHeight(context) * 0.02),
                SizedBox(
                  height: AppSizes.screenHeight(context) * 0.2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3, // Number of offer images
                    itemBuilder: (context, index) {
                      return _buildHorizontalAssetImageCard(
                        context,
                        assetPath:
                            'assets/1c3a2631-eded-484f-884e-a78b4083075e.jpg',
                        margin: EdgeInsets.only(
                          right: AppSizes.screenWidth(context) * 0.03,
                        ),
                      );
                    },
                  ),
                ),

                // Events Section
                SizedBox(height: AppSizes.screenHeight(context) * 0.04),
                Text(
                  'Events',
                  style: TextStyle(
                    fontSize: AppSizes.screenWidth(context) * 0.05,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                ),
                SizedBox(height: AppSizes.screenHeight(context) * 0.02),
                SizedBox(
                  height: AppSizes.screenHeight(context) * 0.2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3, // Number of event images
                    itemBuilder: (context, index) {
                      return _buildHorizontalAssetImageCard(
                        context,
                        assetPath:
                            'assets/1c3a2631-eded-484f-884e-a78b4083075e.jpg',
                        margin: EdgeInsets.only(
                          right: AppSizes.screenWidth(context) * 0.03,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: AppSizes.screenHeight(context) * 0.04),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    final cardWidth = AppSizes.screenWidth(context) * 0.56;
    final imageHeight = AppSizes.screenHeight(context) * 0.1;
    final imageWidth = AppSizes.screenWidth(context) * 0.3;
    final cardRightMargin = AppSizes.screenWidth(context) * 0.03;
    final imageLeftOffset = AppSizes.screenWidth(context) * 0.19;

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CourseDetailsPage(
                courseId: course.id,
                courseTitle: course.title,
                courseDesc: course.description,
                coursePrice: course.price,
                courseDuration: course.duration,
                maxStudent: course.maxStudents,
                certificationEligible: course.certificationEligible,
                isWishlisted: course.wishlisted,
              ),
            ),
          );
        },
        child: Container(
          width: cardWidth + imageLeftOffset,
          margin: EdgeInsets.only(right: cardRightMargin),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: imageWidth * 0.7,
                child: Container(
                  width: cardWidth,
                  child: Card(
                    color: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: imageWidth * 0.4,
                        top: AppSizes.screenHeight(context) * 0.02,
                        right: AppSizes.screenWidth(context) * 0.04,
                        bottom: AppSizes.screenHeight(context) * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title,
                            style: TextStyle(
                              fontSize: AppSizes.screenWidth(context) * 0.035,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          SizedBox(
                              height: AppSizes.screenHeight(context) * 0.005),
                          // Text(
                          //   course.description,
                          //   style: TextStyle(
                          //     fontSize: AppSizes.screenWidth(context) * 0.035,
                          //     color: AppColors.whiteColor,
                          //   ),
                          // ),
                          Text(
                            course.price,
                            style: TextStyle(
                              fontSize:
                                  AppSizes.screenWidth(context) * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: imageHeight * 0.3,
                child: Container(
                  height: imageHeight,
                  width: imageWidth,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 216, 219, 222),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        // Container(
        //   width: cardWidth,
        //   margin: EdgeInsets.only(right: cardRightMargin),
        //   child: Card(
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //     elevation: 2,
        //     child: Padding(
        //       padding: EdgeInsets.all(AppSizes.screenWidth(context) * 0.03),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             course.title,
        //             style: TextStyle(
        //               fontSize: AppSizes.screenWidth(context) * 0.045,
        //               fontWeight: FontWeight.bold,
        //             ),
        //             maxLines: 2,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //           SizedBox(height: AppSizes.screenHeight(context) * 0.01),
        //           Text(
        //             course.description,
        //             style: TextStyle(
        //               fontSize: AppSizes.screenWidth(context) * 0.035,
        //             ),
        //             maxLines: 2,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //           SizedBox(height: AppSizes.screenHeight(context) * 0.01),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text(
        //                 course.price,
        //                 style: TextStyle(
        //                   fontSize: AppSizes.screenWidth(context) * 0.04,
        //                   fontWeight: FontWeight.bold,
        //                   color: AppColors.mainColor,
        //                 ),
        //               ),
        //               Icon(
        //                 course.wishlisted ? Icons.favorite : Icons.favorite_border,
        //                 color: course.wishlisted ? Colors.red : Colors.grey,
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
  // Widget _buildHorizontalCourseCard(
  //     BuildContext context, Map<String, dynamic> course) {
  //   final cardWidth = AppSizes.screenWidth(context) * 0.56;
  //   final imageHeight = AppSizes.screenHeight(context) * 0.1;
  //   final imageWidth = AppSizes.screenWidth(context) * 0.3;
  //   final cardRightMargin = AppSizes.screenWidth(context) * 0.2;
  //   final imageLeftOffset = AppSizes.screenWidth(context) * 0.05;

  //   return Container(
  //     width: cardWidth + imageLeftOffset,
  //     margin: EdgeInsets.only(right: cardRightMargin),
  //     child: Stack(
  //       clipBehavior: Clip.none,
  //       children: [
  //         Positioned(
  //           left: imageWidth * 0.7,
  //           child: Container(
  //             width: cardWidth,
  //             child: Card(
  //               color: AppColors.mainColor,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //               elevation: 2,
  //               child: Padding(
  //                 padding: EdgeInsets.only(
  //                   left: imageWidth * 0.4,
  //                   top: AppSizes.screenHeight(context) * 0.02,
  //                   right: AppSizes.screenWidth(context) * 0.04,
  //                   bottom: AppSizes.screenHeight(context) * 0.02,
  //                 ),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       course['title'],
  //                       style: TextStyle(
  //                         fontSize: AppSizes.screenWidth(context) * 0.045,
  //                         fontWeight: FontWeight.bold,
  //                         color: AppColors.whiteColor,
  //                       ),
  //                     ),
  //                     SizedBox(height: AppSizes.screenHeight(context) * 0.005),
  //                     Text(
  //                       course['description'],
  //                       style: TextStyle(
  //                         fontSize: AppSizes.screenWidth(context) * 0.035,
  //                         color: AppColors.whiteColor,
  //                       ),
  //                     ),
  //                     Text(
  //                       course['price'],
  //                       style: TextStyle(
  //                         fontSize: AppSizes.screenWidth(context) * 0.04,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.blue,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           left: 0,
  //           top: imageHeight * 0.3,
  //           child: Container(
  //             height: imageHeight,
  //             width: imageWidth,
  //             decoration: BoxDecoration(
  //               color: Color.fromARGB(255, 216, 219, 222),
  //               borderRadius: BorderRadius.circular(20),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.1),
  //                   spreadRadius: 1,
  //                   blurRadius: 5,
  //                   offset: Offset(0, 3),
  //                 ),
  //               ],
  //             ),
  //             child: Center(
  //               child: Icon(
  //                 Icons.image,
  //                 size: 40,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildHorizontalAssetImageCard(
    BuildContext context, {
    required String assetPath,
    required EdgeInsets margin,
  }) {
    final cardWidth = AppSizes.screenWidth(context) * 0.6;
    final cardHeight = AppSizes.screenHeight(context) * 0.18;

    return Container(
      width: cardWidth,
      margin: margin,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            assetPath,
            width: cardWidth,
            height: cardHeight,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[200],
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
