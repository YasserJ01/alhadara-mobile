import '../entities/search_booking_request_entity.dart';
import '../entities/result_hall_booking_entity.dart';
import '../repositories/hall_booking_repository.dart';

class SearchHallsUseCase {
  final HallBookingRepository repository;

  SearchHallsUseCase({required this.repository});

  Future<List<HallBookingEntity>> call(BookingRequestEntity request) {
    return repository.searchHalls(request);
  }
}

class HallBookingFailure implements Exception {
  final String message;
  HallBookingFailure({required this.message});
}