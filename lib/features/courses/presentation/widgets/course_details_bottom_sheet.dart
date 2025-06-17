import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/course_schedule_bloc/course_schedule_bloc.dart';
import '../bloc/course_schedule_bloc/course_schedule_event.dart';
import '../bloc/course_schedule_bloc/course_schedule_state.dart';
import 'course_details_card.dart';
import 'course_schedule_list.dart';

class CourseDetailsBottomSheet extends StatefulWidget {
  final int courseId;
  final String courseTitle;
  final String courseDesc;
  final String coursePrice;
  final int courseDuration;
  final int maxStudent;
  final bool certificationEligible;
  final bool isWishlisted;

  const CourseDetailsBottomSheet({
    super.key,
    required this.courseId,
    required this.courseTitle,
    required this.courseDesc,
    required this.coursePrice,
    required this.courseDuration,
    required this.maxStudent,
    required this.certificationEligible,
    required this.isWishlisted,
  });

  @override
  State<CourseDetailsBottomSheet> createState() =>
      _CourseDetailsBottomSheetState();
}

class _CourseDetailsBottomSheetState extends State<CourseDetailsBottomSheet> {
  int? selectedScheduleId;

  void _onScheduleSelected(int scheduleId) {
    setState(() {
      selectedScheduleId = scheduleId;
    });
  }

  final DraggableScrollableController _controller =
      DraggableScrollableController();

  double _sheetPosition = 0.25;

  // Initial position
  @override
  void initState() {
    super.initState();
    _controller.addListener(_onDragUpdate);
    // Only load the schedule since course details are already passed
    context.read<CourseScheduleBloc>().add(LoadCourseSchedule(widget.courseId));
  }

  void _onDragUpdate() {
    setState(() {
      _sheetPosition = _controller.size;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onDragUpdate);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.40,
      minChildSize: 0.40,
      maxChildSize: 0.9,
      controller: _controller,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              // Handle indicator
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Course details section (already available)
              // CourseDetailsCard(courseDetails: widget.courseDetails),
              CourseDetailsCard(
                courseId: widget.courseId,
                courseTitle: widget.courseTitle,
                courseDesc: widget.courseDesc,
                coursePrice: widget.coursePrice,
                courseDuration: widget.courseDuration,
                maxStudent: widget.maxStudent,
                certificationEligible: widget.certificationEligible,
                selectedScheduleId: selectedScheduleId,
                isWishlisted: widget.isWishlisted,
              ),

              const SizedBox(height: 20),

              // Course schedule section (needs to be fetched)
              BlocBuilder<CourseScheduleBloc, CourseScheduleState>(
                builder: (context, state) {
                  if (state is CourseScheduleLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CourseScheduleLoaded) {
                    return CourseScheduleList(
                      schedules: state.schedules,
                      onScheduleSelected: _onScheduleSelected,
                    );
                  } else if (state is CourseScheduleError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const Center(child: Text('No schedule data'));
                },
              ),

              const SizedBox(height: 20),

              // Overview section (already available from course details)
              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Text(widget.courseDetails.overview),
              Text(widget.courseDesc),
            ],
          ),
        );
      },
    );
  }
}
