import '../entities/result_hall_booking_entity.dart';
import '../repositories/hall_booking_repository.dart';

class GetServicesUseCase {
  final HallBookingRepository repository;

  GetServicesUseCase({required this.repository});

  Future<List<ServiceEntity>> call() {
    return repository.getServices();
  }
}