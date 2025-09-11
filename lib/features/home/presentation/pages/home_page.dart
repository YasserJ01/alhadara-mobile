import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/theme/presentation/bloc/theme_bloc.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/notification_badge.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../dependencies.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../../../theme/presentation/widgets/theme_toggle_button.dart';
import '../../../profile/presentation/bloc/create_profile/create_profile_bloc.dart';
import '../../../profile/presentation/bloc/view_profile/profile_bloc.dart';
import '../../../profile/presentation/pages/create_profile_basic_info_page.dart';
import '../bloc/home_bloc.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/home_form.dart';

//home_page.dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeBloc>()..add(LoadHomeData())),
        BlocProvider(create: (context) => getIt<ProfileBloc>()),
        // Theme bloc is already provided from main.dart, so we don't need to create it again
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          // Default theme values
          Color backgroundColor = const Color(0xffF4F8FB);
          Color appBarColor = Colors.white;
          Color textColor = AppColors.mainColor;

          // Apply theme if loaded
          if (themeState is ThemeLoaded) {
            backgroundColor = AppThemeHelper.getBackgroundColor(themeState.theme);
            appBarColor = AppThemeHelper.getCardColor(themeState.theme);
            textColor = AppThemeHelper.getTextColor(themeState.theme);
          }

          return Scaffold(
            drawer: const CustomDrawer(),
            backgroundColor: backgroundColor,
            appBar: AppBar(
              toolbarHeight: AppSizes.screenHeight(context) * 0.09,
              backgroundColor: appBarColor,
              shadowColor: Colors.transparent,
              title: Text(
                l10n.hadara,
                style: TextStyle(
                  color: textColor,
                  fontSize: AppSizes.responsiveFontSize(context,
                      mobile: 32, tablet: 36, desktop: 40),
                ),
              ),
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: textColor,
                    size: AppSizes.screenWidth(context) * 0.09,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              centerTitle: true,
              actions: [
                // Night Mode Toggle Button
                const ThemeToggleButton(
                  iconColor: null, // Will use default based on theme
                  iconSize: 24.0,
                ),
                const SizedBox(width: 8),
                Padding(
                    padding: EdgeInsets.only(right: AppSizes.screenWidth(context) * 0.03),
                    child: const NotificationBadge(count: 3,)
                ),
              ],
            ),
            body: const HomeForm(), // Use themed version
          );
        },
      ),
    );
  }
}