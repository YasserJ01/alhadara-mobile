// lib/features/search/presentation/pages/search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/search_results_widget.dart';
import '../widgets/search_filters_widget.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/search';
  final String? initialQuery;

  const SearchScreen({
    super.key,
    this.initialQuery,
  });

  @override
  Widget build(BuildContext context) {
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

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                // Search Bar Section
                Container(
                  color: cardColor,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Hero(
                        tag: 'search-bar',
                        child: Material(
                          color: Colors.transparent,
                          child: SearchBarWidget(
                            initialQuery: initialQuery,
                            onSearchChanged: (query) {
                              if (query.isNotEmpty) {
                                context.read<SearchBloc>().add(
                                  SearchCoursesEvent(query: query),
                                );
                              } else {
                                context.read<SearchBloc>().add(ClearSearchEvent());
                              }
                            },
                            onFilterTap: () => _showFiltersBottomSheet(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Results Section
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchInitial) {
                        return _buildInitialState(secondaryTextColor);
                      } else if (state is SearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchLoaded) {
                        return SearchResultsWidget(
                          result: state.result,
                          query: state.query,
                        );
                      } else if (state is SearchEmpty) {
                        return _buildEmptyState(state.query, textColor, secondaryTextColor);
                      } else if (state is SearchError) {
                        return _buildErrorState(state.message, textColor, secondaryTextColor);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInitialState(Color secondaryTextColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: secondaryTextColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Search for courses, departments, or course types',
            style: TextStyle(
              fontSize: 16,
              color: secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Use filters to narrow down your search',
            style: TextStyle(
              fontSize: 14,
              color: secondaryTextColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String query, Color textColor, Color secondaryTextColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: secondaryTextColor,
          ),
          const SizedBox(height: 16),
          Text(
            'No results found for "$query"',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search terms or filters',
            style: TextStyle(
              fontSize: 14,
              color: secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message, Color textColor, Color secondaryTextColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _showFiltersBottomSheet(BuildContext context) {
    final searchBloc = context.read<SearchBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          Color cardColor = Colors.white;
          if (themeState is ThemeLoaded) {
            cardColor = AppThemeHelper.getCardColor(themeState.theme);
          }

          return Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SearchFiltersWidget(
              searchBloc: searchBloc,
              onApplyFilters: (filters) {
                searchBloc.add(
                  UpdateFiltersEvent(filters: filters),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
//
// class SearchScreen extends StatelessWidget {
//   static const String routeName = '/search';
//   final String? initialQuery;
//
//   const SearchScreen({
//     super.key,
//     this.initialQuery,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Search Bar Section
//             Container(
//               color: Colors.white,
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Hero(
//                     tag: 'search-bar',
//                     child: Material(
//                       color: Colors.transparent,
//                       child: SearchBarWidget(
//                         initialQuery: initialQuery,
//                         onSearchChanged: (query) {
//                           if (query.isNotEmpty) {
//                             context.read<SearchBloc>().add(
//                               SearchCoursesEvent(query: query),
//                             );
//                           } else {
//                             context.read<SearchBloc>().add(ClearSearchEvent());
//                           }
//                         },
//                         onFilterTap: () => _showFiltersBottomSheet(context),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Results Section
//             Expanded(
//               child: BlocBuilder<SearchBloc, SearchState>(
//                 builder: (context, state) {
//                   if (state is SearchInitial) {
//                     return _buildInitialState();
//                   } else if (state is SearchLoading) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (state is SearchLoaded) {
//                     return SearchResultsWidget(
//                       result: state.result,
//                       query: state.query,
//                     );
//                   } else if (state is SearchEmpty) {
//                     return _buildEmptyState(state.query);
//                   } else if (state is SearchError) {
//                     return _buildErrorState(state.message);
//                   }
//                   return const SizedBox.shrink();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInitialState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.search,
//             size: 80,
//             color: Colors.grey[400],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Search for courses, departments, or course types',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey[600],
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Use filters to narrow down your search',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[500],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(String query) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.search_off,
//             size: 80,
//             color: Colors.grey[400],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'No results found for "$query"',
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Try adjusting your search terms or filters',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildErrorState(String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.error_outline,
//             size: 80,
//             color: Colors.red[400],
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             'Oops! Something went wrong',
//             style:  TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             child: Text(
//               message,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showFiltersBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => SearchFiltersWidget(
//         onApplyFilters: (filters) {
//           context.read<SearchBloc>().add(
//             UpdateFiltersEvent(filters: filters),
//           );
//         },
//       ),
//     );
//   }
// }