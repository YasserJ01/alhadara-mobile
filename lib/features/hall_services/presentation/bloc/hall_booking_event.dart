import "../../domain/entities/search_booking_request_entity.dart";
import '../../domain/entities/hall_booking.dart';
import 'package:equatable/equatable.dart';

abstract class HallBookingEvent extends Equatable {
  const HallBookingEvent();

  @override
  List<Object> get props => [];
}

class SearchHallsEvent extends HallBookingEvent {
  final BookingRequestEntity request;

  const SearchHallsEvent({required this.request});

  @override
  List<Object> get props => [request];
}

class LoadServicesEvent extends HallBookingEvent {}

class CreateBookingEvent extends HallBookingEvent {
  final BookingCreateEntity booking;

  const CreateBookingEvent({required this.booking});

  @override
  List<Object> get props => [booking];
}