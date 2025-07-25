import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/core/constants/app_elevated_button.dart';

class FeedbackPage extends StatelessWidget {
  final int scheduleSlotId;
  final int studentId;

  const FeedbackPage({
    Key? key,
    required this.scheduleSlotId,
    required this.studentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FeedbackBloc>(),
      child: AppScaffold(
        title: 'Feedback',
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: BlocBuilder<FeedbackBloc, FeedbackState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildRatingSection(
                      context,
                      title: 'Teacher Evaluation',
                      description:
                          'How would you rate the teacher\'s performance?',
                      icon: Icons.person_outline,
                      rating: state.teacherRating,
                      onRatingChanged: (rating) {
                        context
                            .read<FeedbackBloc>()
                            .add(TeacherRatingChanged(rating));
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildRatingSection(
                      context,
                      title: 'Material Quality',
                      description: 'How would you rate the course materials?',
                      icon: Icons.menu_book_outlined,
                      rating: state.materialRating,
                      onRatingChanged: (rating) {
                        context
                            .read<FeedbackBloc>()
                            .add(MaterialRatingChanged(rating));
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildRatingSection(
                      context,
                      title: 'Facilities',
                      description:
                          'How would you rate the learning facilities?',
                      icon: Icons.school_outlined,
                      rating: state.facilitiesRating,
                      onRatingChanged: (rating) {
                        context
                            .read<FeedbackBloc>()
                            .add(FacilitiesRatingChanged(rating));
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildRatingSection(
                      context,
                      title: 'App Experience',
                      description: 'How would you rate your app experience?',
                      icon: Icons.phone_iphone_outlined,
                      rating: state.appRating,
                      onRatingChanged: (rating) {
                        context
                            .read<FeedbackBloc>()
                            .add(AppRatingChanged(rating));
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildNotesSection(context, state.notes),
                    const SizedBox(height: 32),
                    _buildSubmitButton(context),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Share Your Feedback',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your opinion helps us improve the learning experience',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required int rating,
    required Function(int) onRatingChanged,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.mainColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => onRatingChanged(index + 1),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade100,
                    ),
                    child: Icon(
                      Icons.star,
                      color: index < rating ? Colors.amber : Colors.grey,
                      size: 32,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '$rating/5',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection(BuildContext context, String notes) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Comments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.mainColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Share any additional thoughts or suggestions',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 4,
              onChanged: (value) {
                context.read<FeedbackBloc>().add(NotesChanged(value));
              },
              decoration: InputDecoration(
                hintText: 'Write your comments here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.mainColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.mainColor, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Center(
      child: AppElevatedButton(
        onPressed: () {
          final state = context.read<FeedbackBloc>().state;
          if (state.teacherRating > 0 &&
              state.materialRating > 0 &&
              state.facilitiesRating > 0 &&
              state.appRating > 0) {
            context.read<FeedbackBloc>().add(SubmitFeedback(
                  scheduleSlotId: scheduleSlotId,
                  studentId: studentId,
                ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please rate all categories before submitting'),
              ),
            );
          }
        },
        child: const Text(
          'Submit Feedback',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
