import '../entities/search_booking_request_entity.dart';
import '../entities/hall_booking.dart';
import '../entities/result_hall_booking_entity.dart';

abstract class HallBookingRepository {
  Future<List<HallBookingEntity>> searchHalls(BookingRequestEntity request);
  Future<List<ServiceEntity>> getServices();
 Future<BookingResponseEntity> createBooking(BookingCreateEntity booking);
}