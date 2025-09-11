import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/loyalty_points/presentation/pages/loyalty_points_page.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../dependencies.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../complaints/presentation/bloc/complaint_bloc.dart';
import '../../../complaints/presentation/pages/complaint_page.dart';
import '../../../enrollment/presentation/bloc/enrollments/enrollment_bloc.dart';
import '../../../enrollment/presentation/pages/enrollment_page.dart';
import '../../../entrance_exam/presentation/bloc/entrance_exam_bloc.dart';
import '../../../entrance_exam/presentation/pages/qr_scanner_page.dart';
import '../../../hall_services/presentation/bloc/hall_booking_bloc.dart';
import '../../../hall_services/presentation/pages/hall_booking_page.dart';
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
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        // Default theme values
        Color backgroundColor = Colors.white;
        Color textColor = AppColors.mainColor;
        Color iconColor = AppColors.mainColor;
        Color cardColor = Colors.white;
        Color secondaryTextColor = Colors.grey[800]!;

        // Apply theme if loaded
        if (themeState is ThemeLoaded) {
          backgroundColor = AppThemeHelper.getBackgroundColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          iconColor = AppThemeHelper.getIconColor(themeState.theme);
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
          secondaryTextColor =
              AppThemeHelper.getSecondaryTextColor(themeState.theme);
        }

        return Drawer(
          backgroundColor: backgroundColor,
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
                                    fontSize:
                                        AppSizes.screenWidth(context) * 0.045,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  '0934945318',
                                  style: TextStyle(
                                    fontSize:
                                        AppSizes.screenWidth(context) * 0.035,
                                    color: secondaryTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Divider(
                            indent: dividerIndent,
                            endIndent: dividerIndent,
                            height: screenHeight * 0.002,
                            color: secondaryTextColor.withOpacity(0.5),
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
                                  icon: Icons.person_outline,
                                  title: l10n.profile,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) =>
                                            getIt<ProfileBloc>(),
                                        child: const ProfilePage(),
                                      ),
                                    ),
                                  ),
                                  containerSize: containerSize,
                                  iconSize: iconSize,
                                  iconColor: iconColor,
                                  cardColor: cardColor,
                                  textColor: secondaryTextColor,
                                ),
                                _buildDrawerCardItem(
                                  context,
                                  icon: Icons.wallet,
                                  title: l10n.wallet,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WalletPage(),
                                    ),
                                  ),
                                  containerSize: containerSize,
                                  iconSize: iconSize,
                                  iconColor: iconColor,
                                  cardColor: cardColor,
                                  textColor: secondaryTextColor,
                                ),
                                _buildDrawerCardItem(
                                  context,
                                  icon: Icons.favorite_border,
                                  title: l10n.wishlist,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) =>
                                            getIt<WishlistBloc>(),
                                        // or your DI method
                                        child: const WishlistPage(),
                                      ),
                                    ),
                                  ),
                                  containerSize: containerSize,
                                  iconSize: iconSize,
                                  iconColor: iconColor,
                                  cardColor: cardColor,
                                  textColor: secondaryTextColor,
                                ),
                                _buildDrawerCardItem(
                                  context,
                                  icon: Icons.app_registration,
                                  title: l10n.enrollments,
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
                                  iconColor: iconColor,
                                  cardColor: cardColor,
                                  textColor: secondaryTextColor,
                                ),
                                _buildDrawerCardItem(
                                  context,
                                  icon: Icons.menu_book_outlined,
                                  title: l10n.courses,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/departments',
                                  ),
                                  containerSize: containerSize,
                                  iconSize: iconSize,
                                  iconColor: iconColor,
                                  cardColor: cardColor,
                                  textColor: secondaryTextColor,
                                ),
                                _buildDrawerCardItem(
                                  context,
                                  icon: Icons.stars,
                                  title: l10n.loyalty,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const LoyaltyPointsPage();
                                      },
                                    ),
                                  ),
                                  containerSize: containerSize,
                                  iconSize: iconSize,
                                  iconColor: iconColor,
                                  cardColor: cardColor,
                                  textColor: secondaryTextColor,
                                ),
                                _buildDrawerCardItem(
                                  context,
                                  icon: Icons.exit_to_app,
                                  title: l10n.entrance,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) =>
                                            getIt<EntranceExamBloc>(),
                                        // or your DI method
                                        child: const QrScannerPage(),
                                      ),
                                    ),
                                  ),
                                  containerSize: containerSize,
                                  iconSize: iconSize,
                                  iconColor: iconColor,
                                  cardColor: cardColor,
                                  textColor: secondaryTextColor,
                                ),
                                _buildDrawerCardItem(
                                  context,
                                  icon: Icons.assignment_add,
                                  title: 'Complaints',
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) =>
                                            getIt<ComplaintBloc>(),
                                        child: ComplaintPage(),
                                      ),
                                    ),
                                  ),
                                  containerSize: containerSize,
                                  iconSize: iconSize,
                                  iconColor: iconColor,
                                  cardColor: cardColor,
                                  textColor: secondaryTextColor,
                                ),
                                _buildDrawerCardItem(
                                  context,
                                  icon: Icons.calendar_month,
                                  title: 'Hall booking',
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) =>
                                            getIt<HallBookingBloc>(),
                                        child: HallBookingPage(),
                                      ),
                                    ),
                                  ),
                                  containerSize: containerSize,
                                  iconSize: iconSize,
                                  iconColor: iconColor,
                                  cardColor: cardColor,
                                  textColor: secondaryTextColor,
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
                            color: secondaryTextColor.withOpacity(0.5),
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
                                  icon: Icons.logout,
                                  title: "Logout", // Make sure to add 'logout' to your localization
                                  onTap: () => _showLogoutConfirmationDialog(context),
                                  containerSize: containerSize,
                                  iconSize: iconSize,
                                  iconColor: Colors.red, // Use red color for logout to indicate danger
                                  cardColor: cardColor,
                                  textColor: Colors.red, // Use red color for text
                                ),
                                // Add the same parameters to other bottom items...
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
                    color: cardColor,
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
                      color: iconColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawerCardItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required double containerSize,
    required double iconSize,
    required Color iconColor,
    required Color cardColor,
    required Color textColor,
  }) {
    return Card(
      color: cardColor,
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
            color: cardColor,
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
            color: iconColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: AppSizes.screenWidth(context) * 0.04,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final l10n = AppLocalizations.of(context);

      return AlertDialog(
        title: Text("Log out"),
        content: Text("Are You sure you want to log out ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close drawer
              _performLogout(context);
            },
            child: Text(
              "Logout",
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
void _performLogout(BuildContext context) {
  // Dispatch logout event to AuthBloc
  context.read<AuthBloc>().add(
    const LogoutRequested(clearSavedCredentials: true),
  );

  // Navigate to login screen or handle navigation as needed
  // This depends on your app's navigation structure
  Navigator.pushNamedAndRemoveUntil(
    context,
    '/start', // Replace with your login route
        (route) => false,
  );
}
