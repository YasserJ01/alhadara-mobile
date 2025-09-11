import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/search/presentation/bloc/search_bloc.dart';
import 'package:project2/features/search/presentation/pages/search_screen.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/no_item.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../dependencies.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../../courses/domain/entites/course.dart';
import '../../../courses/presentation/pages/course_details_page.dart';
import '../../../profile/presentation/bloc/create_profile/create_profile_bloc.dart';
import '../../../profile/presentation/bloc/view_profile/profile_bloc.dart';
import '../../../profile/presentation/pages/create_profile_basic_info_page.dart';
import '../bloc/home_bloc.dart';

//home_form.dart
class HomeForm extends StatefulWidget {
  const HomeForm({super.key});

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  bool _profileChecked = false;

  @override
  void initState() {
    super.initState();
    // Trigger profile check when widget first loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(const LoadProfile());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (!_profileChecked && state is ProfileNotFound) {
          _profileChecked = true; // Mark as checked
          _showProfileNotFoundDialog(context);
        }
      },
      child: _buildHomeContent(),
    );
  }

  Widget _buildHomeContent() {
    final padding = AppSizes.screenWidth(context) * 0.04;
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        // Default colors
        Color textColor = AppColors.mainColor;
        Color cardColor = Colors.white;
        Color secondaryTextColor = Colors.grey;

        // Apply theme if loaded
        if (themeState is ThemeLoaded) {
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
          secondaryTextColor =
              AppThemeHelper.getSecondaryTextColor(themeState.theme);
        }

        return BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial || state is HomeLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: textColor,
                ),
              );
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
                    // Container(
                    //   height: AppSizes.screenHeight(context) * 0.06,
                    //   decoration: BoxDecoration(
                    //     color: cardColor,
                    //     borderRadius: BorderRadius.circular(20),
                    //     border: themeState is ThemeLoaded &&
                    //             themeState.theme.isDarkMode
                    //         ? Border.all(color: Colors.grey[700]!, width: 0.5)
                    //         : null,
                    //   ),
                    //   child: TextField(
                    //     style: TextStyle(color: textColor),
                    //     decoration: InputDecoration(
                    //       hintText: l10n.search,
                    //       hintStyle: TextStyle(color: secondaryTextColor),
                    //       prefixIcon: Icon(
                    //         Icons.search,
                    //         color: secondaryTextColor,
                    //         size: 35,
                    //       ),
                    //       border: InputBorder.none,
                    //     ),
                    //   ),
                    // ),

                    // Courses Section
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
                                  create: (context) => getIt<SearchBloc>(),
                                  // or your DI method
                                  child: const SearchScreen(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: AppSizes.screenHeight(context) * 0.06,
                            decoration: BoxDecoration(
                              color: cardColor,
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Icon(
                                    Icons.search,
                                    color: secondaryTextColor,
                                    size: 24,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Search courses, departments...',
                                    style: TextStyle(
                                      color: secondaryTextColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Icon(
                                    Icons.tune,
                                    color: secondaryTextColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Offers Section
                    SizedBox(height: AppSizes.screenHeight(context) * 0.04),
                    Text(
                      l10n.offers,
                      style: TextStyle(
                        fontSize: AppSizes.screenWidth(context) * 0.05,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: AppSizes.screenHeight(context) * 0.02),
                    state.dealsCourses.isNotEmpty
                        ? SizedBox(
                      height: AppSizes.screenHeight(context) * 0.2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.dealsCourses.length,
                        itemBuilder: (context, index) {
                          final course = state.dealsCourses[index];
                          return _buildDealCourseCard(context, course);
                        },
                      ),
                    )
                        : NoItemWidget(
                      message: 'No offers available',
                      icon: Icons.local_offer,
                      iconColor: Colors.orange,
                    ),

                    SizedBox(height: AppSizes.screenHeight(context) * 0.04),
                    Text(
                      l10n.recommendation,
                      style: TextStyle(
                        fontSize: AppSizes.screenWidth(context) * 0.05,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: AppSizes.screenHeight(context) * 0.02),

                    // Horizontal Scrollable Courses
                    state.recommendedCourses.isNotEmpty
                        ? SizedBox(
                            height: AppSizes.screenHeight(context) * 0.2,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.recommendedCourses.length,
                              itemBuilder: (context, index) {
                                final course = state.recommendedCourses[index];
                                return _buildCourseCard(
                                    context, course, textColor, cardColor);
                              },
                            ),
                          )
                        : const NoItemWidget(
                            message: 'No recommendations available',
                            icon: Icons.error_outline,
                            iconColor: Colors.orange,
                          ),

                    // // Events Section
                    // SizedBox(height: AppSizes.screenHeight(context) * 0.04),
                    // Text(
                    //   'Events',
                    //   style: TextStyle(
                    //     fontSize: AppSizes.screenWidth(context) * 0.05,
                    //     fontWeight: FontWeight.bold,
                    //     color: textColor,
                    //   ),
                    // ),
                    // SizedBox(height: AppSizes.screenHeight(context) * 0.02),
                    // SizedBox(
                    //   height: AppSizes.screenHeight(context) * 0.2,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 3, // Number of event images
                    //     itemBuilder: (context, index) {
                    //       return _buildHorizontalAssetImageCard(
                    //         context,
                    //         assetPath:
                    //             'assets/1c3a2631-eded-484f-884e-a78b4083075e.jpg',
                    //         margin: EdgeInsets.only(
                    //           right: AppSizes.screenWidth(context) * 0.03,
                    //         ),
                    //         cardColor: cardColor,
                    //       );
                    //     },
                    //   ),
                    // ),
                    // SizedBox(height: AppSizes.screenHeight(context) * 0.04),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  void _showProfileNotFoundDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Profile Required'),
        content: const Text('You need to create a profile to use this app.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => getIt<CreateProfileBloc>(),
                    child: const CreateProfileBasicInfoPage(),
                  ),
                ),
              );
            },
            child: const Text('Create Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(
      BuildContext context, Course course, Color textColor, Color cardColor) {
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
                  color: textColor, // Use theme color for card
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
                            color: cardColor, // Inverse color for text on card
                          ),
                        ),
                        SizedBox(
                            height: AppSizes.screenHeight(context) * 0.005),
                        Text(
                          course.price,
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
                  color: cardColor,
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
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 40,
                    color: textColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDealCourseCard(BuildContext context, Course course) {
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
              hasDiscount: course.hasDiscount,
              // أضف هذا
              discountInfo: course.discountInfo,
              // أضف هذا
              originalPrice: course.originalPrice,
              canEnroll: course.canEnroll,
              languageMessage: course.languageMessage,
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
                  color: Colors.orange, // لون مختلف للعروض
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                            height: AppSizes.screenHeight(context) * 0.005),
                        if (course.hasDiscount)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${course.discountInfo?.discountPercentage.toString()}% OFF',
                                style: TextStyle(
                                  fontSize:
                                      AppSizes.screenWidth(context) * 0.03,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${course.originalPrice}',
                                    style: TextStyle(
                                        fontSize:
                                            AppSizes.screenWidth(context) *
                                                0.03,
                                        color: AppColors.whiteColor,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.black),
                                  ),
                                  SizedBox(
                                    width: AppSizes.screenWidth(context) * 0.01,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: AppSizes.screenWidth(context) * 0.03,
                                    color: AppColors.whiteColor,
                                  ),
                                  SizedBox(
                                    width: AppSizes.screenWidth(context) * 0.01,
                                  ),
                                  Text(
                                    '${course.price}',
                                    style: TextStyle(
                                      fontSize:
                                          AppSizes.screenWidth(context) * 0.03,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        else
                          Text(
                            course.price,
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
            // شارة العروض
            if (course.hasDiscount)
              Positioned(
                top: 0,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'OFFER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalAssetImageCard(
    BuildContext context, {
    required String assetPath,
    required EdgeInsets margin,
    required Color cardColor,
  }) {
    final cardWidth = AppSizes.screenWidth(context) * 0.6;
    final cardHeight = AppSizes.screenHeight(context) * 0.18;

    return Container(
      width: cardWidth,
      margin: margin,
      child: Card(
        color: cardColor,
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
              color: cardColor,
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
