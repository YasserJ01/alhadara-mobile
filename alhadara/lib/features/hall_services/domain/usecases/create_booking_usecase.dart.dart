import 'package:alhadara/features/hall_services/domain/entities/hall_booking.dart';
import 'package:alhadara/features/hall_services/domain/repositories/hall_booking_repository.dart';

class CreateBookingUseCase {
  final HallBookingRepository repository;

  CreateBookingUseCase({required this.repository});

  Future<BookingResponseEntity> call(BookingCreateEntity booking) {
    return repository.createBooking(booking);
  }
}