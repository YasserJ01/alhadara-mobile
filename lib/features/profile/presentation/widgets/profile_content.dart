import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/l10n/generated/app_localizations.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/theme/app_theme_helper.dart';
import '../../../../theme/presentation/bloc/theme_bloc.dart';
import '../../../../theme/presentation/bloc/theme_state.dart';
import '../../domain/entity/profile.dart';
import 'interest_chip.dart';

//profile_content.dart
class ProfileContent extends StatefulWidget {
  final Profile profile;

  const ProfileContent({Key? key, required this.profile}) : super(key: key);

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  void _showFullScreenImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.white,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        // Default theme values
        Color backgroundColor = const Color(0xffF4F8FB);
        Color textColor = AppColors.mainColor;
        Color secondaryTextColor = Colors.grey[800]!;
        Color iconColor = AppColors.mainColor;
        Color cardColor = Colors.white;

        // Apply theme if loaded
        if (themeState is ThemeLoaded) {
          backgroundColor = AppThemeHelper.getBackgroundColor(themeState.theme);
          textColor = AppThemeHelper.getTextColor(themeState.theme);
          secondaryTextColor =
              AppThemeHelper.getSecondaryTextColor(themeState.theme);
          iconColor = AppThemeHelper.getIconColor(themeState.theme);
          cardColor = AppThemeHelper.getCardColor(themeState.theme);
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              // Profile Picture and Edit Button
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: GestureDetector(
                      onTap: widget.profile.image != null
                          ? () => _showFullScreenImage(widget.profile.image!)
                          : () {},
                      child: Hero(
                        tag: 'imageHero',
                        child: widget.profile.image == null
                            ? CircleAvatar(
                                radius: 30.0,
                                backgroundColor:
                                    secondaryTextColor.withOpacity(0.1),
                                child: Icon(Icons.person,
                                    size: 60, color: secondaryTextColor),
                              )
                            : CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(
                                  widget.profile.image!,
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: iconColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.edit, color: cardColor, size: 16),
                        onPressed: () {},
                        constraints: const BoxConstraints(
                          minWidth: 42,
                          minHeight: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              // Greeting Text
              Text(
                widget.profile.fullName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.personalInfo,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildProfileField(
                      Icons.event_outlined,
                      l10n.birthDate,
                      _formatDate(widget.profile.birthDate),
                      iconColor: iconColor,
                      cardColor: cardColor,
                      textColor: textColor,
                      secondaryTextColor: secondaryTextColor,
                    ),
                    const SizedBox(height: 12),
                    _buildProfileField(
                      widget.profile.gender == "male"
                          ? Icons.male_outlined
                          : Icons.female_outlined,
                      l10n.gender,
                      _capitalizeFirst(widget.profile.gender),
                      iconColor: iconColor,
                      cardColor: cardColor,
                      textColor: textColor,
                      secondaryTextColor: secondaryTextColor,
                    ),
                    const SizedBox(height: 12),
                    _buildProfileField(
                      Icons.location_on_outlined,
                      l10n.address,
                      widget.profile.address,
                      iconColor: iconColor,
                      cardColor: cardColor,
                      textColor: textColor,
                      secondaryTextColor: secondaryTextColor,
                    ),
                    const SizedBox(height: 12),

                    // Academic Details Section - Conditionally shown based on academicStatus
                    if (widget.profile.academicStatus != "not_studying") ...[
                      Text(
                        l10n.academicInfo,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildProfileField(
                        Icons.workspace_premium_outlined,
                        l10n.academicStatus,
                        _capitalizeFirst(widget.profile.academicStatus),
                        iconColor: iconColor,
                        cardColor: cardColor,
                        textColor: textColor,
                        secondaryTextColor: secondaryTextColor,
                      ),
                      const SizedBox(height: 12),

                      // Only show university and study field if not high_school
                      if (widget.profile.academicStatus != "high_school") ...[
                        _buildProfileField(
                          Icons.school_outlined,
                          l10n.university,
                          widget.profile.universityName ?? "None",
                          iconColor: iconColor,
                          cardColor: cardColor,
                          textColor: textColor,
                          secondaryTextColor: secondaryTextColor,
                        ),
                        const SizedBox(height: 12),
                        _buildProfileField(
                          Icons.menu_book_outlined,
                          l10n.studyField,
                          widget.profile.studyfieldName ?? "None",
                          iconColor: iconColor,
                          cardColor: cardColor,
                          textColor: textColor,
                          secondaryTextColor: secondaryTextColor,
                        ),
                        const SizedBox(height: 12),
                      ],
                    ],

                    if(widget.profile.englishLevelDisplay != null || widget.profile.spanishLevelDisplay != null || widget.profile.frenchLevelDisplay != null || widget.profile.germanLevelDisplay != null )...[
                    Text(
                      "Languages Level",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ],
                    // if (widget.profile.academicStatus != "high_school") ...
                    if (widget.profile.englishLevelDisplay != null) ...[
                      _buildProfileField(
                        Icons.language,
                        l10n.english,
                        widget.profile.englishLevelDisplay ?? "None",
                        iconColor: iconColor,
                        cardColor: cardColor,
                        textColor: textColor,
                        secondaryTextColor: secondaryTextColor,
                      ),
                      const SizedBox(height: 12),
                    ],

                    if (widget.profile.frenchLevelDisplay != null) ...[
                      _buildProfileField(
                        Icons.language,
                        l10n.english,
                        widget.profile.frenchLevelDisplay ?? "None",
                        iconColor: iconColor,
                        cardColor: cardColor,
                        textColor: textColor,
                        secondaryTextColor: secondaryTextColor,
                      ),
                      const SizedBox(height: 12),
                    ],

                    if (widget.profile.spanishLevelDisplay != null) ...[
                      _buildProfileField(
                        Icons.language,
                        l10n.english,
                        widget.profile.spanishLevelDisplay ?? "None",
                        iconColor: iconColor,
                        cardColor: cardColor,
                        textColor: textColor,
                        secondaryTextColor: secondaryTextColor,
                      ),
                      const SizedBox(height: 12),
                    ],

                    if (widget.profile.germanLevelDisplay != null) ...[
                      _buildProfileField(
                        Icons.language,
                        l10n.english,
                        widget.profile.germanLevelDisplay ?? "None",
                        iconColor: iconColor,
                        cardColor: cardColor,
                        textColor: textColor,
                        secondaryTextColor: secondaryTextColor,
                      ),
                      const SizedBox(height: 12),
                    ],


                    // Interests Section
                    Text(
                      l10n.yourInterests,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: iconColor.withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: iconColor.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: widget.profile.interests
                                .map((interest) =>
                                    InterestChip(interest: interest))
                                .toList(),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileField(
    IconData icon,
    String label,
    String value, {
    required Color iconColor,
    required Color cardColor,
    required Color textColor,
    required Color secondaryTextColor,
  }) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: cardColor,
          ),
          child: Icon(icon, color: iconColor),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: secondaryTextColor,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: iconColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final months = [
        '',
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      return '${date.day} ${months[date.month]} ${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
