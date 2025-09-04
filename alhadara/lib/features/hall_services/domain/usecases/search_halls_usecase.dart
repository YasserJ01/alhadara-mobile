import 'package:alhadara/features/hall_services/domain/entities/search_booking_request_entity.dart';
import 'package:alhadara/features/hall_services/domain/entities/result_hall_booking_entity.dart';
import 'package:alhadara/features/hall_services/domain/repositories/hall_booking_repository.dart';

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