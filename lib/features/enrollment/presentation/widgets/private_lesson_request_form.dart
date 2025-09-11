import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_elevated_button.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/colors.dart';
import '../bloc/private_lesson_request/private_lesson_request_bloc.dart';
import '../pages/get_private_lesson_page.dart';

class PrivateLessonRequestForm extends StatefulWidget {
  final int scheduleSlotId;

  const PrivateLessonRequestForm({
    super.key,
    required this.scheduleSlotId,
  });

  @override
  State<PrivateLessonRequestForm> createState() =>
      _PrivateLessonRequestFormState();
}

class _PrivateLessonRequestFormState extends State<PrivateLessonRequestForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  String get _formattedDate {
    return _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : '';
  }

  String get _formattedStartTime {
    if (_selectedStartTime == null) return '';
    final now = DateTime.now();
    final dt = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedStartTime!.hour,
      _selectedStartTime!.minute,
    );
    return DateFormat('HH:mm:ss').format(dt);
  }

  String get _formattedEndTime {
    if (_selectedEndTime == null) return '';
    final now = DateTime.now();
    final dt = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedEndTime!.hour,
      _selectedEndTime!.minute,
    );
    return DateFormat('HH:mm:ss').format(dt);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.mainColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.mainColor,
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.mainColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.mainColor,
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedStartTime = picked;
        if (_selectedEndTime == null || _selectedEndTime!.hour <= picked.hour) {
          _selectedEndTime = TimeOfDay(
            hour: (picked.hour + 1) % 24,
            minute: picked.minute,
          );
        }
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime?.replacing(
              hour: (_selectedStartTime!.hour + 1) % 24) ??
          TimeOfDay.now().replacing(hour: (TimeOfDay.now().hour + 1) % 24),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.mainColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.mainColor,
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedEndTime = picked;
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay? time) {
    if (time == null) return '';
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.responsiveSize(
                    context,
                    mobile: 15,
                    tablet: 18,
                    desktop: 20)),
                side: BorderSide(color: AppColors.mainColor.withOpacity(0.4)),
              ),
              shadowColor: Colors.black.withOpacity(0.4),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Preferred Date',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => _selectDate(context),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8), // Increased padding
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.mainColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.mainColor.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? DateFormat('EEEE, MMM d, y')
                                      .format(_selectedDate!)
                                  : 'Select a date',
                              style: TextStyle(
                                color: _selectedDate != null
                                    ? Colors.black
                                    : Colors.grey.shade700,
                              ),
                            ),
                            const Icon(
                              Icons.calendar_today,
                              size: 20,
                              color: AppColors.mainColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.responsiveSize(
                    context,
                    mobile: 15,
                    tablet: 18,
                    desktop: 20)),
                side: BorderSide(color: AppColors.mainColor.withOpacity(0.4)),
              ),
              shadowColor: Colors.black.withOpacity(0.4),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Preferred Time',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectStartTime(context),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8), // Increased padding
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.mainColor.withOpacity(0.3),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.mainColor.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _selectedStartTime != null
                                        ? _formatTimeOfDay(_selectedStartTime)
                                        : 'Start time',
                                    style: TextStyle(
                                      color: _selectedStartTime != null
                                          ? Colors.black
                                          : Colors.grey.shade700,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.access_time,
                                    size: 20,
                                    color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('to'),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectEndTime(context),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8), // Increased padding
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.mainColor.withOpacity(0.3),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.mainColor.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _selectedEndTime != null
                                        ? _formatTimeOfDay(_selectedEndTime)
                                        : 'End time',
                                    style: TextStyle(
                                      color: _selectedEndTime != null
                                          ? Colors.black
                                          : Colors.grey.shade700,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.access_time,
                                    size: 20,
                                    color: AppColors.mainColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            BlocConsumer<PrivateLessonRequestBloc, PrivateLessonRequestState>(
              listener: (context, state) {
                if (state.status == PrivateLessonRequestStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Request submitted successfully!'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const PrivateLessonRequestsListPage(),
                    ),
                  );
                } else if (state.status == PrivateLessonRequestStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${state.errorMessage}'),
                      behavior: SnackBarBehavior.floating,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return AppElevatedButton(
                  onPressed: state.status == PrivateLessonRequestStatus.loading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select a date'),
                                ),
                              );
                              return;
                            }
                            if (_selectedStartTime == null ||
                                _selectedEndTime == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select time range'),
                                ),
                              );
                              return;
                            }

                            context.read<PrivateLessonRequestBloc>().add(
                                  SubmitPrivateLessonRequest(
                                    scheduleSlot: widget.scheduleSlotId,
                                    preferredDate: _formattedDate,
                                    preferredTimeFrom: _formattedStartTime,
                                    preferredTimeTo: _formattedEndTime,
                                  ),
                                );
                          }
                        },
                  child: state.status == PrivateLessonRequestStatus.loading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Submit Request',
                          style: TextStyle(fontSize: 16),
                        ),
                );
                // ElevatedButton(
                //   onPressed:
                //state.status == PrivateLessonRequestStatus.loading
                //       ? null
                //       : () {
                //           if (_formKey.currentState!.validate()) {
                //             if (_selectedDate == null) {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 const SnackBar(
                //                   content: Text('Please select a date'),
                //                 ),
                //               );
                //               return;
                //             }
                //             if (_selectedStartTime == null ||
                //                 _selectedEndTime == null) {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 const SnackBar(
                //                   content: Text('Please select time range'),
                //                 ),
                //               );
                //               return;
                //             }

                //             context.read<PrivateLessonRequestBloc>().add(
                //                   SubmitPrivateLessonRequest(
                //                     scheduleSlot: widget.scheduleSlotId,
                //                     preferredDate: _formattedDate,
                //                     preferredTimeFrom: _formattedStartTime,
                //                     preferredTimeTo: _formattedEndTime,
                //                   ),
                //                 );
                //           }
                //         },
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(vertical: 16),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //   ),
                //   child:
                // state.status == PrivateLessonRequestStatus.loading
                //       ? const SizedBox(
                //           height: 24,
                //           width: 24,
                //           child: CircularProgressIndicator(
                //             color: Colors.white,
                //             strokeWidth: 2,
                //           ),
                //         )
                //       : const Text(
                //           'Submit Request',
                //           style: TextStyle(fontSize: 16),
                //         ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
