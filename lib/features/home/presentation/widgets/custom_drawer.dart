import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/colors.dart';
import '../../../../dependencies.dart';
import '../../../enrollment/presentation/bloc/enrollments/enrollment_bloc.dart';
import '../../../enrollment/presentation/pages/enrollment_page.dart';
import '../../../profile/presentation/bloc/view_profile/profile_bloc.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../wallet/presentation/pages/wallet_page.dart';
import '../../../wishlist/presentation/bloc/wishlist_bloc.dart';
import '../../../wishlist/presentation/pages/wishlist_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = AppSizes.screenWidth(context) * 0.06;
    final containerSize = AppSizes.screenWidth(context) * 0.12;
    final padding = AppSizes.screenWidth(context) * 0.03;
    final dividerIndent = AppSizes.screenWidth(context) * 0.05;
    final closeIconSize = AppSizes.screenWidth(context) * 0.07;
    final screenHeight = AppSizes.screenHeight(context);

    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      // User Profile Section
                      Container(
                        padding: EdgeInsets.only(
                          top: AppSizes.paddingTop(context) +
                              screenHeight * 0.02,
                          bottom: screenHeight * 0.02,
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: AppSizes.screenWidth(context) * 0.25,
                              height: AppSizes.screenWidth(context) * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.mainColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.person,
                                size: iconSize,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              'Yasser Jeroodi',
                              style: TextStyle(
                                fontSize: AppSizes.screenWidth(context) * 0.045,
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainColor,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text(

                              '0934945318',
                              style: TextStyle(
                                fontSize: AppSizes.screenWidth(context) * 0.035,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        indent: dividerIndent,
                        endIndent: dividerIndent,
                        height: screenHeight * 0.002,
                        color: const Color.fromARGB(255, 172, 170, 170),
                        thickness: screenHeight * 0.001,
                      ),

                      // Main Navigation Items
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: padding,
                          vertical: screenHeight * 0.01,
                        ),
                        child: Column(
                          children: [
                            _buildDrawerCardItem(
                              context,
                              icon: Icons.home_outlined,
                              title: 'Home',
                              onTap: () => Navigator.pop(context),
                              containerSize: containerSize,
                              iconSize: iconSize,
                            ),
                            _buildDrawerCardItem(
                              context,
                              icon: Icons.person_outline,
                              title: 'Profile',
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => getIt<ProfileBloc>(),
                                    // or your DI method
                                    child: const ProfilePage(),
                                  ),
                                ),
                              ),
                              containerSize: containerSize,
                              iconSize: iconSize,
                            ),
                            _buildDrawerCardItem(
                              context,
                              icon: Icons.location_on_outlined,
                              title: 'Location',
                              onTap: () => Navigator.pop(context),
                              containerSize: containerSize,
                              iconSize: iconSize,
                            ),
                            _buildDrawerCardItem(
                              context,
                              icon: Icons.wallet,
                              title: 'Your Wallet',
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WalletPage(),
                                ),
                              ),
                              containerSize: containerSize,
                              iconSize: iconSize,
                            ),
                            _buildDrawerCardItem(
                              context,
                              icon: Icons.favorite_border,
                              title: 'Wishlist',
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => getIt<WishlistBloc>(), // or your DI method
                                    child: const WishlistPage(),
                                  ),
                                ),
                              ),
                              containerSize: containerSize,
                              iconSize: iconSize,
                            ),
                            _buildDrawerCardItem(
                              context,
                              icon: Icons.app_registration,
                              title: 'Enrollments',
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) =>
                                            getIt<EnrollmentBloc>()
                                              ..add(FetchEnrollments()),
                                      ),
                                    ],
                                    child: const EnrollmentsPage(),
                                  ),
                                ),
                              ),
                              containerSize: containerSize,
                              iconSize: iconSize,
                            ),
                            _buildDrawerCardItem(
                              context,
                              icon: Icons.menu_book_outlined,
                              title: 'Courses',
                              onTap: () => Navigator.pushNamed(
                                context,
                                '/departments',
                              ),
                              containerSize: containerSize,
                              iconSize: iconSize,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Divider(
                        indent: dividerIndent,
                        endIndent: dividerIndent,
                        height: screenHeight * 0.002,
                        color: const Color.fromARGB(255, 172, 170, 170),
                        thickness: screenHeight * 0.001,
                      ),

                      // Bottom Navigation Items
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: padding,
                          vertical: screenHeight * 0.01,
                        ),
                        child: Column(
                          children: [
                            _buildDrawerCardItem(
                              context,
                              icon: Icons.contact_support_outlined,
                              title: 'Contact Info',
                              onTap: () => Navigator.pop(context),
                              containerSize: containerSize,
                              iconSize: iconSize,
                            ),
                            _buildDrawerCardItem(
                              context,
                              icon: Icons.account_circle_outlined,
                              title: 'Account',
                              onTap: () => Navigator.pop(context),
                              containerSize: containerSize,
                              iconSize: iconSize,
                            ),
                            _buildDrawerCardItem(
                              context,
                              icon: Icons.exit_to_app_outlined,
                              title: 'Exit',
                              onTap: () => Navigator.pop(context),
                              containerSize: containerSize,
                              iconSize: iconSize,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Close (X) Icon Button
          Positioned(
            top: AppSizes.paddingTop(context) + screenHeight * 0.01,
            right: AppSizes.screenWidth(context) * 0.03,
            child: Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(containerSize),
                color: const Color.fromARGB(255, 247, 222, 224),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: closeIconSize,
                  color: AppColors.mainColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerCardItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required double containerSize,
    required double iconSize,
  }) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(
        vertical: AppSizes.screenHeight(context) * 0.008,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppSizes.screenWidth(context) * 0.02),
      ),
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.2),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.screenWidth(context) * 0.04,
          vertical: AppSizes.screenHeight(context) * 0.01,
        ),
        leading: Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(containerSize),
            color: const Color.fromARGB(255, 247, 222, 224),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 3,
                spreadRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
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
            fontSize: AppSizes.screenWidth(context) * 0.04,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
