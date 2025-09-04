import 'dart:convert';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/hall_services/presentation/bloc/hall_booking_state.dart';
import 'package:alhadara/features/hall_services/presentation/widgets/booking_type_dropdown.dart';
import 'package:alhadara/features/hall_services/presentation/widgets/search_button.dart';
import 'package:alhadara/features/hall_services/presentation/widgets/services_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/features/hall_services/data/models/search_booking_request_model.dart';
import 'package:alhadara/features/hall_services/domain/entities/search_booking_request_entity.dart';
import 'package:alhadara/features/hall_services/domain/entities/result_hall_booking_entity.dart';
import 'package:alhadara/features/hall_services/presentation/bloc/hall_booking_bloc.dart';
import 'package:alhadara/features/hall_services/presentation/bloc/hall_booking_event.dart';
import 'package:alhadara/features/hall_services/presentation/pages/hall_results_page.dart';
import 'package:alhadara/features/hall_services/presentation/widgets/styled_text_field.dart';

class BookingFormFields extends StatefulWidget {
  const BookingFormFields({super.key});

  @override
  State<BookingFormFields> createState() => _BookingFormFieldsState();
}

class _BookingFormFieldsState extends State<BookingFormFields> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _attendeesController = TextEditingController();
  DateTime? _selectedDate;
  final _selectedServices = <int>{};
  String _bookingType = 'public';

  @override
  Widget build(BuildContext context) {
    return BlocListener<HallBookingBloc, HallBookingState>(
      listener: (context, state) {
        if (state is HallBookingLoaded) {
          _navigateToResultsPage(context, state.halls, state.searchRequest);
        } else if (state is HallBookingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(4),
          children: [
            StyledTextField(
              controller: _dateController,
              labelText: 'Date',
              onTap: () => _selectDate(context),
              isReadOnly: true,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please select date' : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: StyledTextField(
                    controller: _startTimeController,
                    labelText: 'Start Time',
                    onTap: () => _selectTime(context, true),
                    isReadOnly: true,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please select start time'
                        : null,
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          _endTimeController.text.isNotEmpty) {
                        if (!_isTimeAfter(_endTimeController.text, value)) {
                          _endTimeController.clear();
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StyledTextField(
                    controller: _endTimeController,
                    labelText: 'End Time',
                    onTap: () => _selectTime(context, false),
                    isReadOnly: true,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please select end time'
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            StyledTextField(
              controller: _attendeesController,
              labelText: 'Number of Attendees',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value?.isEmpty ?? true)
                  return 'Please enter number of attendees';
                if (int.tryParse(value!) == null)
                  return 'Please enter a valid number';
                return null;
              },
            ),
            const SizedBox(height: 16),
            BookingTypeDropdown(
              bookingType: _bookingType,
              onChanged: (newValue) {
                setState(() {
                  _bookingType = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),
            ServicesSection(
              selectedServices: _selectedServices,
              onServiceSelected: (serviceId, selected) {
                setState(() {
                  if (selected) {
                    _selectedServices.add(serviceId);
                  } else {
                    _selectedServices.remove(serviceId);
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            SearchButton(
              onPressed: _searchHalls,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.mainColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.mainColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay initialTime;

    if (isStartTime) {
      initialTime = TimeOfDay.now();
    } else {
      if (_startTimeController.text.isNotEmpty) {
        final startParts = _startTimeController.text.split(':');
        final startHour = int.parse(startParts[0]);
        final startMinute = int.parse(startParts[1]);
        initialTime = TimeOfDay(hour: startHour, minute: startMinute + 1);
      } else {
        initialTime = TimeOfDay.fromDateTime(
            DateTime.now().add(const Duration(hours: 1)));
      }
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.mainColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.mainColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final timeStr =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      if (isStartTime) {
        _startTimeController.text = timeStr;

        if (_endTimeController.text.isNotEmpty &&
            !_isTimeAfter(_endTimeController.text, timeStr)) {
          _endTimeController.clear();
        }
      } else {
        _endTimeController.text = timeStr;
      }
    }
  }

  void _searchHalls() {
    if (_formKey.currentState?.validate() ?? false) {
      final attendees = int.tryParse(_attendeesController.text) ?? 0;

      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please select a date'),
            backgroundColor: AppColors.mainColor,
          ),
        );
        return;
      }

      if (_startTimeController.text.isEmpty ||
          _endTimeController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please select start and end time'),
            backgroundColor: AppColors.mainColor,
          ),
        );
        return;
      }

      final startTime = _startTimeController.text;
      final endTime = _endTimeController.text;

      if (!_isTimeAfter(endTime, startTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('End time must be after start time'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final request = BookingRequestEntity(
        date: _selectedDate!,
        startTime: startTime,
        endTime: endTime,
        numberOfAttendees: attendees,
        serviceIds: _selectedServices.toList(),
        bookingType: _bookingType,
      );

      // Debug print
      final requestModel = BookingRequestModel(
        date: request.date,
        startTime: request.startTime,
        endTime: request.endTime,
        numberOfAttendees: request.numberOfAttendees,
        serviceIds: request.serviceIds,
        bookingType: request.bookingType,
      );

      requestModel.printDebugInfo();
      print('JSON: ${json.encode(requestModel.toJson())}');

      context.read<HallBookingBloc>().add(SearchHallsEvent(request: request));
    }
  }

  bool _isTimeAfter(String time1, String time2) {
    try {
      final time1Parts = time1.split(':');
      final time2Parts = time2.split(':');

      final time1Hour = int.parse(time1Parts[0]);
      final time1Minute = int.parse(time1Parts[1]);
      final time2Hour = int.parse(time2Parts[0]);
      final time2Minute = int.parse(time2Parts[1]);

      if (time1Hour > time2Hour) {
        return true;
      } else if (time1Hour == time2Hour) {
        return time1Minute > time2Minute;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void _navigateToResultsPage(BuildContext context,
      List<HallBookingEntity> halls, BookingRequestEntity searchRequest) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => getIt<HallBookingBloc>(),
          child: HallResultsPage(halls: halls, searchRequest: searchRequest),
        ),
      ),
    );
    //           create: (context) => getIt<EnrollmentBloc>()..add(FetchEnrollments()),

    //           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               // builder: (context) => Onboarding(),
//               builder: (context) => BlocProvider(
//                 create: (context) => OnboardingBloc(),
//                 child: Onboarding(),
//               ),
//             ),
//           );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _attendeesController.dispose();
    super.dispose();
  }
}
