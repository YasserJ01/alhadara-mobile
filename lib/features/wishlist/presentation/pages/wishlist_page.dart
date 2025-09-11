// presentation/pages/wishlist_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/l10n/generated/app_localizations.dart';
import '../../../../core/constants/app_elevated_button.dart';
import '../../../../core/constants/app_scaffold.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../bloc/wishlist_bloc.dart';
import '../bloc/wishlist_event.dart';
import '../bloc/wishlist_state.dart';
import '../../domain/entities/wishlist.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color backgroundColor = const Color(0xffF4F8FB);
        Color cardColor = Colors.white;
        Color textColor = AppColors.mainColor;
        Color secondaryTextColor = Colors.grey[600]!;

        if (themeState is ThemeLoaded) {
          backgroundColor = AppThemeHelper.getBackgroundColor(themeState.theme);
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          secondaryTextColor = AppThemeHelper.getSecondaryTextColor(themeState.theme);
        }

        return AppScaffold(
          title: l10n.wishlist,
          edgeInsets: const EdgeInsets.all(0),
          body: BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              if (state is WishlistInitial) {
                context.read<WishlistBloc>().add(LoadWishlistsEvent());
                return const Center(child: CircularProgressIndicator());
              } else if (state is WishlistLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WishlistLoaded) {
                if (state.wishlists.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 80,
                          color: secondaryTextColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.noWishlistCourses,
                          style: TextStyle(
                            fontSize: 18,
                            color: secondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.startAddingCourses,
                          style: TextStyle(
                            fontSize: 14,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<WishlistBloc>().add(LoadWishlistsEvent());
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _getTotalCourses(state.wishlists),
                    itemBuilder: (context, index) {
                      final courseData = _getCourseAtIndex(state.wishlists, index);
                      return _buildCourseCard(courseData, cardColor, textColor, secondaryTextColor);
                    },
                  ),
                );
              } else if (state is WishlistError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 80,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.failedToLoadWishlist,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppElevatedButton(
                        onPressed: () {
                          context.read<WishlistBloc>().add(LoadWishlistsEvent());
                        },
                        child: Text(l10n.retry),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }

  int _getTotalCourses(List<Wishlist> wishlists) {
    return wishlists.fold(
        0, (total, wishlist) => total + wishlist.courses.length);
  }

  Map<String, String> _getCourseAtIndex(List<Wishlist> wishlists, int index) {
    int currentIndex = 0;
    for (final wishlist in wishlists) {
      for (final course in wishlist.courses) {
        if (currentIndex == index) {
          return {
            'title': course.title,
            'courseTypeName': course.courseTypeName,
          };
        }
        currentIndex++;
      }
    }
    return {'title': '', 'courseTypeName': ''};
  }

  Widget _buildCourseCard(Map<String, String> courseData, Color cardColor, Color textColor, Color secondaryTextColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 5,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseData['title'] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: secondaryTextColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      courseData['courseTypeName'] ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}