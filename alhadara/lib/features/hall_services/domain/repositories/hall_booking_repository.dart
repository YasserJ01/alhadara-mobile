import 'package:alhadara/features/hall_services/domain/entities/search_booking_request_entity.dart';
import 'package:alhadara/features/hall_services/domain/entities/hall_booking.dart';
import 'package:alhadara/features/hall_services/domain/entities/result_hall_booking_entity.dart';

abstract class HallBookingRepository {
  Future<List<HallBookingEntity>> searchHalls(BookingRequestEntity request);
  Future<List<ServiceEntity>> getServices();
 Future<BookingResponseEntity> createBooking(BookingCreateEntity booking);
}