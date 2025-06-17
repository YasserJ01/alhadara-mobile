// // presentation/widgets/course_schedule_list.dart
// import 'package:flutter/material.dart';
//
// import '../../domain/entites/course_schedule.dart';
//
// class CourseScheduleList extends StatelessWidget {
//   final List<CourseSchedule> schedules;
//
//   const CourseScheduleList({Key? key, required this.schedules})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // const Text(
//         //   'Times',
//         //   style: TextStyle(
//         //     fontSize: 16,
//         //     fontWeight: FontWeight.bold,
//         //   ),
//         // ),
//         // const SizedBox(height: 10),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: schedules.length,
//           itemBuilder: (context, index) {
//             final schedule = schedules[index];
//             return Card(
//               margin: const EdgeInsets.only(bottom: 10),
//               elevation: 0,
//               color: Colors.grey.shade100,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.grey.shade200,
//                               foregroundColor: Colors.black,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                             child: const Text('SUN TUE THU'),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red,
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                             child: Text(
//                               '${schedule.daysOfWeek[0].toUpperCase()} ${schedule.daysOfWeek[1].toUpperCase()} ${schedule.daysOfWeek[2].toUpperCase()}',
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             '${schedule.formattedStartTime} - ${schedule.formattedEndTime}',
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Text(
//                             schedule.formattedStartDate,
//                             style: const TextStyle(fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Text(
//                             schedule.hallName,
//                             style: const TextStyle(fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
// presentation/widgets/course_schedule_list.dart
import 'package:flutter/material.dart';

import '../../domain/entites/course_schedule.dart';

class CourseScheduleList extends StatefulWidget {
  final List<CourseSchedule> schedules;
  final Function(int) onScheduleSelected;

  const CourseScheduleList({
    Key? key,
    required this.schedules,
    required this.onScheduleSelected,
  }) : super(key: key);

  @override
  State<CourseScheduleList> createState() => _CourseScheduleListState();
}

class _CourseScheduleListState extends State<CourseScheduleList> {
  int selectedScheduleIndex = 0;

  @override
  void initState() {
    super.initState();
    // Notify parent of initial selection
    if (widget.schedules.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onScheduleSelected(widget.schedules[selectedScheduleIndex].id);
      });
    }
  }

  String _formatDaysOfWeek(List<String> days) {
    return days.map((day) => day.substring(0, 3).toUpperCase()).join(' • ');
  }

  String _getScheduleLabel(CourseSchedule schedule) {
    return '${_formatDaysOfWeek(schedule.daysOfWeek)} (${schedule.formattedStartTime} - ${schedule.formattedEndTime})';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.schedules.isEmpty) {
      return const SizedBox.shrink();
    }

    final selectedSchedule = widget.schedules[selectedScheduleIndex];

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with schedule selector
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: Colors.blue.shade600,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Schedule Options',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                if (widget.schedules.length > 1)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${selectedScheduleIndex + 1} of ${widget.schedules.length}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Schedule selector dropdown (only show if more than 1 schedule)
            if (widget.schedules.length > 1) ...[
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade50,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: selectedScheduleIndex,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey.shade600),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedScheduleIndex = newValue;
                        });
                        widget.onScheduleSelected(
                          widget.schedules[newValue].id,
                        );
                      }
                    },
                    items: widget.schedules.asMap().entries.map((entry) {
                      int index = entry.key;
                      CourseSchedule schedule = entry.value;
                      return DropdownMenuItem<int>(
                        value: index,
                        child: Text(_getScheduleLabel(schedule)),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Selected schedule details card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.blue.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Days and time row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _formatDaysOfWeek(selectedSchedule.daysOfWeek),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Text(
                          '${selectedSchedule.formattedStartTime} - ${selectedSchedule.formattedEndTime}',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Details grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          Icons.location_on_outlined,
                          'Hall',
                          selectedSchedule.hallName,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Expanded(
                      //   child: _buildDetailItem(
                      //     Icons.person_outline,
                      //     'Teacher',
                      //     selectedSchedule.teacherName,
                      //   ),
                      // ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          Icons.calendar_today_outlined,
                          'Start Date',
                          selectedSchedule.formattedStartDate,
                        ),
                      ),
                      // const SizedBox(width: 16),
                      // Expanded(
                      //   child: _buildDetailItem(
                      //     Icons.access_time,
                      //     'Duration',
                      //     '${selectedSchedule.durationHours} hours',
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
