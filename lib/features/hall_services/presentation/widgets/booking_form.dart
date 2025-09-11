

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/hall_booking_bloc.dart';
import '../bloc/hall_booking_event.dart';
import '../bloc/hall_booking_state.dart';
import 'booking_form_fields.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  @override
  void initState() {
    super.initState();
    context.read<HallBookingBloc>().add(LoadServicesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HallBookingBloc, HallBookingState>(
      listener: (context, state) {
        if (state is ServicesLoaded) {
          // يمكن التعامل مع حالة تحميل الخدمات إذا لزم الأمر
        } else if (state is HallBookingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: const BookingFormFields(),
    );
  }
}