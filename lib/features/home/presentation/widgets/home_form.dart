import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/search/presentation/bloc/search_bloc.dart';
import 'package:project2/features/search/presentation/pages/search_screen.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/no_item.dart';
import '../../../../dependencies.dart';
import '../bloc/home_bloc.dart';

// Updated HomeForm with search integration
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
                // Search Bar - Now with Hero animation
                SizedBox(height: AppSizes.screenHeight(context) * 0.02),
                Hero(
                  tag: 'search-bar',
                  child: Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => getIt<SearchBloc>(), // or your DI method
                              child: const SearchScreen(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: AppSizes.screenHeight(context) * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 24,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Search courses, departments...',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Icon(
                                Icons.tune,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                color: const Color.fromARGB(255, 216, 219, 222),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
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
              child: const Center(
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
//
// class HomeForm extends StatelessWidget {
//   const HomeForm({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final padding = AppSizes.screenWidth(context) * 0.04;
//
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
//                   child: const TextField(
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
//
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
//
//                 // Horizontal Scrollable Courses
//                 SizedBox(
//                   height: AppSizes.screenHeight(context) * 0.2,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: state.featuredCourses.length,
//                     itemBuilder: (context, index) {
//                       final course = state.featuredCourses[index];
//                       return _buildHorizontalCourseCard(context, course);
//                     },
//                   ),
//                 ),
//
//                 // Offers Section
//                 SizedBox(height: AppSizes.screenHeight(context) * 0.01),
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
//                     itemCount: 3, // Number of offer images
//                     itemBuilder: (context, index) {
//                       return _buildHorizontalAssetImageCard(
//                         context,
//                         assetPath:
//                             'assets/1c3a2631-eded-484f-884e-a78b4083075e.jpg',
//                         margin: EdgeInsets.only(
//                           right: AppSizes.screenWidth(context) * 0.03,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//
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
//                     itemCount: 3, // Number of event images
//                     itemBuilder: (context, index) {
//                       return _buildHorizontalAssetImageCard(
//                         context,
//                         assetPath:
//                             'assets/1c3a2631-eded-484f-884e-a78b4083075e.jpg',
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
//
//   Widget _buildHorizontalCourseCard(
//       BuildContext context, Map<String, dynamic> course) {
//     final cardWidth = AppSizes.screenWidth(context) * 0.56;
//     final imageHeight = AppSizes.screenHeight(context) * 0.1;
//     final imageWidth = AppSizes.screenWidth(context) * 0.3;
//     final cardRightMargin = AppSizes.screenWidth(context) * 0.2;
//     final imageLeftOffset = AppSizes.screenWidth(context) * 0.05;
//
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
//                 color: const Color.fromARGB(255, 216, 219, 222),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 5,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: const Center(
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
//
//   Widget _buildHorizontalAssetImageCard(
//     BuildContext context, {
//     required String assetPath,
//     required EdgeInsets margin,
//   }) {
//     final cardWidth = AppSizes.screenWidth(context) * 0.6;
//     final cardHeight = AppSizes.screenHeight(context) * 0.18;
//
//     return Container(
//       width: cardWidth,
//       margin: margin,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         elevation: 2,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: Image.asset(
//             assetPath,
//             width: cardWidth,
//             height: cardHeight,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) => Container(
//               color: Colors.grey[200],
//               child: const Center(
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
