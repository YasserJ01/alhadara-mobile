import '../../domain/entities/result_hall_booking_entity.dart';
import '../../domain/entities/hall_booking.dart';
import '../../domain/entities/search_booking_request_entity.dart';
import 'package:equatable/equatable.dart';

abstract class HallBookingState extends Equatable {
  const HallBookingState();

  @override
  List<Object> get props => [];
}

class HallBookingInitial extends HallBookingState {}

class HallBookingLoading extends HallBookingState {}

class HallBookingLoaded extends HallBookingState {
  final List<HallBookingEntity> halls;
  final BookingRequestEntity searchRequest;


  const HallBookingLoaded({required this.halls,required this.searchRequest});

  @override
  List<Object> get props => [halls,searchRequest];
}

class HallBookingError extends HallBookingState {
  final String message;

  const HallBookingError({required this.message});

  @override
  List<Object> get props => [message];
}

class ServicesLoading extends HallBookingState {}

class ServicesLoaded extends HallBookingState {
  final List<ServiceEntity> services;

  const ServicesLoaded({required this.services});

  @override
  List<Object> get props => [services];
}

class ServicesError extends HallBookingState {
  final String message;

  const ServicesError({required this.message});

  @override
  List<Object> get props => [message];
}

// New booking states
class BookingCreating extends HallBookingState {}

class BookingCreated extends HallBookingState {
  final BookingResponseEntity booking;

  const BookingCreated({required this.booking});

  @override
  List<Object> get props => [booking];
}

class BookingCreationError extends HallBookingState {
  final String message;

  const BookingCreationError({required this.message});

  @override
  List<Object> get props => [message];
}