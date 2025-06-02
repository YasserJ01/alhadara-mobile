// import 'package:alhadara/features/home/presentation/bloc/home_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:alhadara/core/constants/app_size.dart';
// import 'package:alhadara/core/constants/colors.dart';
// import 'package:alhadara/core/constants/no_item.dart';

// class HomeForm extends StatelessWidget {
//   const HomeForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final padding = AppSizes.screenWidth(context) * 0.04;

//     return BlocBuilder<HomeBloc, HomeState>(
//       builder: (context, state) {
//         if (state is HomeInitial || state is HomeLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is HomeError) {
//           return NoItemWidget(
//             message: state.message,
//             icon: Icons.error_outline,
//             iconColor: Colors.red,
//           );
//         } else if (state is HomeLoaded) {
//           return SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: padding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Search Bar
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.02),
//                 Container(
//                   height: AppSizes.screenHeight(context) * 0.06,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search',
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: Colors.grey,
//                         size: 35,
//                       ),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),

//                 // Courses Section
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.04),
//                 Text(
//                   'Courses',
//                   style: TextStyle(
//                     fontSize: AppSizes.screenWidth(context) * 0.05,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.mainColor,
//                   ),
//                 ),
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.02),

//                 // Horizontal Scrollable Courses
//                 SizedBox(
//                   height: AppSizes.screenHeight(context) * 0.25,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: state.featuredCourses.length,
//                     itemBuilder: (context, index) {
//                       final course = state.featuredCourses[index];
//                       return _buildHorizontalCourseCard(context, course);
//                     },
//                   ),
//                 ),

//                 // Offers Section
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.04),
//                 Text(
//                   'Offers',
//                   style: TextStyle(
//                     fontSize: AppSizes.screenWidth(context) * 0.05,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.mainColor,
//                   ),
//                 ),
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.02),
//                 Container(
//                   height: AppSizes.screenHeight(context) * 0.15,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Center(
//                     child: Text('Offers content goes here'),
//                   ),
//                 ),

//                 // Events Section
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.04),
//                 Text(
//                   'Events',
//                   style: TextStyle(
//                     fontSize: AppSizes.screenWidth(context) * 0.05,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.mainColor,
//                   ),
//                 ),
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.02),
//                 Container(
//                   height: AppSizes.screenHeight(context) * 0.15,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Center(
//                     child: Text('Events content goes here'),
//                   ),
//                 ),
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.04),
//               ],
//             ),
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }

//   Widget _buildHorizontalCourseCard(
//       BuildContext context, Map<String, dynamic> course) {
//     final cardWidth = AppSizes.screenWidth(context) * 0.56;
//     final imageHeight = AppSizes.screenHeight(context) * 0.1;
//     final imageWidth = AppSizes.screenWidth(context) * 0.3;
//     final cardRightMargin = AppSizes.screenWidth(context) * 0.2;
//     final imageLeftOffset = AppSizes.screenWidth(context) * 0.05;

//     return Container(
//       width: cardWidth + imageLeftOffset,
//       margin: EdgeInsets.only(right: cardRightMargin),
//       child: Stack(
//         clipBehavior: Clip.none, // Allows widgets to overflow
//         children: [
//           // Card positioned to the right
//           Positioned(
//             left: imageWidth * 0.7, // Adjust this to control overlap
//             child: Container(
//               width: cardWidth,
//               child: Card(
//                 color: AppColors.mainColor,
//                 //color: Color(0xffD6001B),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 elevation: 2,
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     left: imageWidth * 0.4, // Space for the overlapping image
//                     top: AppSizes.screenHeight(context) * 0.02,
//                     right: AppSizes.screenWidth(context) * 0.04,
//                     bottom: AppSizes.screenHeight(context) * 0.02,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         course['title'],
//                         style: TextStyle(
//                           fontSize: AppSizes.screenWidth(context) * 0.045,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.whiteColor,
//                         ),
//                       ),
//                       SizedBox(height: AppSizes.screenHeight(context) * 0.005),
//                       Text(
//                         course['description'],
//                         style: TextStyle(
//                           fontSize: AppSizes.screenWidth(context) * 0.035,
//                           color: AppColors.whiteColor,
//                         ),
//                       ),
//                       Text(
//                         course['price'],
//                         style: TextStyle(
//                           fontSize: AppSizes.screenWidth(context) * 0.04,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Image container positioned to the left and slightly above
//           Positioned(
//             left: 0,
//             top: imageHeight *
//                 0.3, // Adjust this to control how much it overlaps
//             child: Container(
//               height: imageHeight,
//               width: imageWidth,
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 216, 219, 222), // Placeholder color
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.image,
//                   size: 40,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:alhadara/features/home/presentation/bloc/home_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:alhadara/core/constants/app_size.dart';
// import 'package:alhadara/core/constants/colors.dart';
// import 'package:alhadara/core/constants/no_item.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeForm extends StatelessWidget {
//   const HomeForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final padding = AppSizes.screenWidth(context) * 0.04;

//     return BlocBuilder<HomeBloc, HomeState>(
//       builder: (context, state) {
//         if (state is HomeInitial || state is HomeLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is HomeError) {
//           return NoItemWidget(
//             message: state.message,
//             icon: Icons.error_outline,
//             iconColor: Colors.red,
//           );
//         } else if (state is HomeLoaded) {
//           return SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: padding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Search Bar
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.02),
//                 Container(
//                   height: AppSizes.screenHeight(context) * 0.06,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search',
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: Colors.grey,
//                         size: 35,
//                       ),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),

//                 // Courses Section
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.04),
//                 Text(
//                   'Courses',
//                   style: TextStyle(
//                     fontSize: AppSizes.screenWidth(context) * 0.05,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.mainColor,
//                   ),
//                 ),
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.02),

//                 // Horizontal Scrollable Courses
//                 SizedBox(
//                   height: AppSizes.screenHeight(context) * 0.25,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: state.featuredCourses.length,
//                     itemBuilder: (context, index) {
//                       final course = state.featuredCourses[index];
//                       return _buildHorizontalCourseCard(context, course);
//                     },
//                   ),
//                 ),

//                 // Offers Section
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.04),
//                 Text(
//                   'Offers',
//                   style: TextStyle(
//                     fontSize: AppSizes.screenWidth(context) * 0.05,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.mainColor,
//                   ),
//                 ),
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.02),
//                 SizedBox(
//                   height: AppSizes.screenHeight(context) * 0.2,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 5, // Replace with your actual offer count
//                     itemBuilder: (context, index) {
//                       return _buildHorizontalImageCard(
//                         context,
//                         imageUrl:
//                             'https://example.com/offer_$index.jpg', // Replace with your image URL
//                         margin: EdgeInsets.only(
//                           right: AppSizes.screenWidth(context) * 0.03,
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 // Events Section
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.04),
//                 Text(
//                   'Events',
//                   style: TextStyle(
//                     fontSize: AppSizes.screenWidth(context) * 0.05,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.mainColor,
//                   ),
//                 ),
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.02),
//                 SizedBox(
//                   height: AppSizes.screenHeight(context) * 0.2,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 5, // Replace with your actual event count
//                     itemBuilder: (context, index) {
//                       return _buildHorizontalImageCard(
//                         context,
//                         imageUrl:
//                             'https://example.com/event_$index.jpg', // Replace with your image URL
//                         margin: EdgeInsets.only(
//                           right: AppSizes.screenWidth(context) * 0.03,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.04),
//               ],
//             ),
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }

//   Widget _buildHorizontalCourseCard(
//       BuildContext context, Map<String, dynamic> course) {
//     final cardWidth = AppSizes.screenWidth(context) * 0.56;
//     final imageHeight = AppSizes.screenHeight(context) * 0.1;
//     final imageWidth = AppSizes.screenWidth(context) * 0.3;
//     final cardRightMargin = AppSizes.screenWidth(context) * 0.2;
//     final imageLeftOffset = AppSizes.screenWidth(context) * 0.05;

//     return Container(
//       width: cardWidth + imageLeftOffset,
//       margin: EdgeInsets.only(right: cardRightMargin),
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Positioned(
//             left: imageWidth * 0.7,
//             child: Container(
//               width: cardWidth,
//               child: Card(
//                 color: AppColors.mainColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 elevation: 2,
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     left: imageWidth * 0.4,
//                     top: AppSizes.screenHeight(context) * 0.02,
//                     right: AppSizes.screenWidth(context) * 0.04,
//                     bottom: AppSizes.screenHeight(context) * 0.02,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         course['title'],
//                         style: TextStyle(
//                           fontSize: AppSizes.screenWidth(context) * 0.045,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.whiteColor,
//                         ),
//                       ),
//                       SizedBox(height: AppSizes.screenHeight(context) * 0.005),
//                       Text(
//                         course['description'],
//                         style: TextStyle(
//                           fontSize: AppSizes.screenWidth(context) * 0.035,
//                           color: AppColors.whiteColor,
//                         ),
//                       ),
//                       Text(
//                         course['price'],
//                         style: TextStyle(
//                           fontSize: AppSizes.screenWidth(context) * 0.04,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: 0,
//             top: imageHeight * 0.3,
//             child: Container(
//               height: imageHeight,
//               width: imageWidth,
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 216, 219, 222),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.image,
//                   size: 40,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHorizontalImageCard(
//     BuildContext context, {
//     required String imageUrl,
//     required EdgeInsets margin,
//   }) {
//     final cardWidth = AppSizes.screenWidth(context) * 0.6;
//     final cardHeight = AppSizes.screenHeight(context) * 0.18;

//     return Container(
//       width: cardWidth,
//       height: cardHeight,
//       margin: margin,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         elevation: 2,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: Image.network(
//             imageUrl,
//             width: cardWidth,
//             height: cardHeight,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) => Container(
//               color: Colors.grey[200],
//               child: Center(
//                 child: Icon(
//                   Icons.image,
//                   size: 40,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
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
                  'Courses',
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
                    itemCount: state.featuredCourses.length,
                    itemBuilder: (context, index) {
                      final course = state.featuredCourses[index];
                      return _buildHorizontalCourseCard(context, course);
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

  Widget _buildHorizontalCourseCard(
      BuildContext context, Map<String, dynamic> course) {
    final cardWidth = AppSizes.screenWidth(context) * 0.56;
    final imageHeight = AppSizes.screenHeight(context) * 0.1;
    final imageWidth = AppSizes.screenWidth(context) * 0.3;
    final cardRightMargin = AppSizes.screenWidth(context) * 0.2;
    final imageLeftOffset = AppSizes.screenWidth(context) * 0.05;

    return Container(
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
                        course['title'],
                        style: TextStyle(
                          fontSize: AppSizes.screenWidth(context) * 0.045,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: AppSizes.screenHeight(context) * 0.005),
                      Text(
                        course['description'],
                        style: TextStyle(
                          fontSize: AppSizes.screenWidth(context) * 0.035,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Text(
                        course['price'],
                        style: TextStyle(
                          fontSize: AppSizes.screenWidth(context) * 0.04,
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
    );
  }

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
