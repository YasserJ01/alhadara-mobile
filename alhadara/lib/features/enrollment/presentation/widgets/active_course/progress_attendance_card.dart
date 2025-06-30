import 'package:alhadara/core/constants/colors.dart';
import 'package:flutter/material.dart';

class ProgressAttendanceCard extends StatelessWidget {
  final double progress;
  final double attendance;
  final int? lessons;
  final int? lessonsCount;
  final String courseTitle;

  const ProgressAttendanceCard(
      {super.key,
      required this.progress,
      required this.attendance,
      required this.courseTitle,
      this.lessons,
      this.lessonsCount});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: AppColors.mainColor.withOpacity(0.4))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Card(
            //   elevation: 4,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(16),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(16),
            //     child: Text(
            //       courseTitle,
            //       style: const TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: AppColors.mainColor,
            //       ),
            //     ),
            //   ),
            // ),
            Text(
              courseTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // const Text(
            //   'Course Performance',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //     color: AppColors.mainColor,
            //   ),
            // ),
            // const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircularProgress(
                  value: progress / 100,
                  title: 'Progress',
                  percentage: progress,
                  color: _getProgressColor(progress),
                ),
                Container(
                  width: 1,
                  height: 100,
                  color: Colors.grey.shade300,
                ),
                _buildCircularProgress(
                  value: attendance / 100,
                  title: 'Attendance',
                  percentage: attendance.toDouble(),
                  color: _getAttendanceColor(attendance),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildStatsRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularProgress({
    required double value,
    required String title,
    required double percentage,
    required Color color,
  }) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.mainColor.withOpacity(0.1),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 187, 185, 185)
                .withOpacity(0.6), // Themed shadow color
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(Icons.menu_book, 'Lessons', lessonsCount.toString()),
          _buildStatItem(Icons.room, 'Hall', lessonsCount.toString()),
          _buildStatItem(
              Icons.access_time_filled, 'Time', lessonsCount.toString()),
          //  _buildStatItem(Icons.assignment, 'Completed', '28'),
          // _buildStatItem(Icons.people, 'Present', '85%'),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppColors.mainColor.withOpacity(0.8)),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(double progress) {
    if (progress >= 80) return Colors.green;
    if (progress >= 50) return Colors.blueAccent;
    return Colors.red;
  }

  Color _getAttendanceColor(double attendance) {
    if (attendance >= 90) return Colors.green;
    if (attendance >= 70) return Colors.blueAccent;
    if (attendance >= 50) return Colors.red;
    return Colors.red;
  }
}
