// lib/features/search/presentation/widgets/search_results_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../domain/entities/search_result.dart';

class SearchResultsWidget extends StatelessWidget {
  final SearchResult result;
  final String query;

  const SearchResultsWidget({
    super.key,
    required this.result,
    required this.query,
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

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Query Display
              Text(
                'Results for "$query"',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${_getTotalResultsCount()} results found',
                style: TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 24),

              // Departments Section
              if (result.departments.isNotEmpty) ...[
                _buildSectionHeader('Departments', result.departments.length, textColor, secondaryTextColor),
                const SizedBox(height: 12),
                ...result.departments.map((dept) => _buildDepartmentCard(dept, cardColor, textColor, secondaryTextColor)),
                const SizedBox(height: 24),
              ],

              // Course Types Section
              if (result.courseTypes.isNotEmpty) ...[
                _buildSectionHeader('Course Types', result.courseTypes.length, textColor, secondaryTextColor),
                const SizedBox(height: 12),
                ...result.courseTypes.map((type) => _buildCourseTypeCard(type, cardColor, textColor, secondaryTextColor)),
                const SizedBox(height: 24),
              ],

              // Courses Section
              if (result.courses.isNotEmpty) ...[
                _buildSectionHeader('Courses', result.courses.length, textColor, secondaryTextColor),
                const SizedBox(height: 12),
                ...result.courses.map((course) => _buildCourseCard(course, cardColor, textColor, secondaryTextColor)),
              ],
            ],
          ),
        );
      },
    );
  }

  int _getTotalResultsCount() {
    return result.departments.length + result.courseTypes.length + result.courses.length;
  }

  Widget _buildSectionHeader(String title, int count, Color textColor, Color secondaryTextColor) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: secondaryTextColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDepartmentCard(Department department, Color cardColor, Color textColor, Color secondaryTextColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.business,
                  color: Colors.purple[600],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      department.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      department.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: secondaryTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseTypeCard(CourseType courseType, Color cardColor, Color textColor, Color secondaryTextColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.category,
                  color: Colors.green[600],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseType.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      courseType.departmentName,
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: secondaryTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard(Course course, Color cardColor, Color textColor, Color secondaryTextColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.school,
                      color: Colors.blue[600],
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          course.departmentName,
                          style: TextStyle(
                            fontSize: 14,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\ ${course.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      if (course.certificationEligible)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Certified',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[800],
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                course.description,
                style: TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoChip(Icons.schedule, '${course.duration} weeks', secondaryTextColor),
                  const SizedBox(width: 8),
                  _buildInfoChip(Icons.people, '${course.maxStudents} max', secondaryTextColor),
                  const SizedBox(width: 8),
                  _buildCategoryChip(course.category),
                  const Spacer(),
                  if (course.isInWishlist)
                    Icon(
                      Icons.favorite,
                      color: Colors.red[400],
                      size: 20,
                    )
                  else
                    Icon(
                      Icons.favorite_border,
                      color: secondaryTextColor,
                      size: 20,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color secondaryTextColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: secondaryTextColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: secondaryTextColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isWorkshop = category.toLowerCase() == 'workshop';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isWorkshop ? Colors.purple[100] : Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        category.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isWorkshop ? Colors.purple[800] : Colors.blue[800],
        ),
      ),
    );
  }
}
