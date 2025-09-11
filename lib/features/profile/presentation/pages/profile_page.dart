import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/dependencies.dart';
import 'package:project2/l10n/generated/app_localizations.dart';
import '../../../../core/constants/app_elevated_button.dart';
import '../../../../core/constants/app_scaffold.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../bloc/create_profile/create_profile_bloc.dart';
import '../bloc/view_profile/profile_bloc.dart';
import '../widgets/profile_content.dart';
import 'create_profile_basic_info_page.dart';

//profile_page.dart
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()
        ..add(
          const LoadProfile(),
        ),
      child: AppScaffold(
        title: l10n.profile,
        icon: Icons.home_outlined,
        onPressedEndIcon: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const HomePage();
              },
            ),
          );
        },
        elevation: 5,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return ProfileContent(profile: state.profile);
            } else if (state is ProfileNotFound) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, themeState) {
                          Color iconColor = AppColors.mainColor;
                          if (themeState is ThemeLoaded) {
                            iconColor = AppThemeHelper.getIconColor(themeState.theme);
                          }
                          return Icon(
                            Icons.person_add_alt_1,
                            size: 64,
                            color: iconColor,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, themeState) {
                          Color textColor = AppColors.mainColor;
                          if (themeState is ThemeLoaded) {
                            textColor = AppThemeHelper.getTextColor(themeState.theme);
                          }
                          return Text(
                            l10n.noProfileFound,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, themeState) {
                          Color secondaryColor = Colors.grey;
                          if (themeState is ThemeLoaded) {
                            secondaryColor = AppThemeHelper.getSecondaryTextColor(themeState.theme);
                          }
                          return Text(
                            l10n.noProfileFoundMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: secondaryColor
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, themeState) {
                          Color textColor = AppColors.mainColor;
                          Color cardColor = Colors.white;
                          if (themeState is ThemeLoaded) {
                            textColor = AppThemeHelper.getTextColor(themeState.theme);
                            cardColor = AppThemeHelper.getCardColor(themeState.theme);
                          }
                          return AppElevatedButton(
                            backgroundColor: cardColor,
                            side: BorderSide(color: textColor),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => getIt<CreateProfileBloc>(),
                                    child: const CreateProfileBasicInfoPage(),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              l10n.createProfile,
                              style: TextStyle(
                                fontSize: 20,
                                color: textColor,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    BlocBuilder<ThemeBloc, ThemeState>(
                      builder: (context, themeState) {
                        Color secondaryColor = Colors.grey[600]!;
                        if (themeState is ThemeLoaded) {
                          secondaryColor = AppThemeHelper.getSecondaryTextColor(themeState.theme);
                        }
                        return Text(
                          'Error loading profile',
                          style: TextStyle(
                              fontSize: 18,
                              color: secondaryColor
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<ThemeBloc, ThemeState>(
                      builder: (context, themeState) {
                        Color secondaryColor = Colors.grey[500]!;
                        if (themeState is ThemeLoaded) {
                          secondaryColor = AppThemeHelper.getSecondaryTextColor(themeState.theme);
                        }
                        return Text(
                          state.message,
                          style: TextStyle(
                              fontSize: 14,
                              color: secondaryColor
                          ),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(LoadProfile());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}