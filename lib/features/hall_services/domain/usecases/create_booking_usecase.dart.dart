import '../entities/hall_booking.dart';
import '../repositories/hall_booking_repository.dart';

class CreateBookingUseCase {
  final HallBookingRepository repository;

  CreateBookingUseCase({required this.repository});

  Future<BookingResponseEntity> call(BookingCreateEntity booking) {
    return repository.createBooking(booking);
  }
}