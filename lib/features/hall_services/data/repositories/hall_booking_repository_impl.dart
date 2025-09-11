import '..'
    '/../../../errors/expections.dart';
import '../datasources/hall_booking_remote_data_source.dart';
import '../models/search_booking_request_model.dart';
import '../models/hall_booking.dart';
import '../../domain/entities/search_booking_request_entity.dart';
import '../../domain/entities/hall_booking.dart';
import '../../domain/entities/result_hall_booking_entity.dart';
import '../../domain/repositories/hall_booking_repository.dart';
import '../../domain/usecases/search_halls_usecase.dart';

class HallBookingRepositoryImpl implements HallBookingRepository {
  final HallBookingRemoteDataSource remoteDataSource;

  HallBookingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<HallBookingEntity>> searchHalls(BookingRequestEntity request) async {
    try {
      final requestModel = BookingRequestModel(
        date: request.date,
        startTime: request.startTime,
        endTime: request.endTime,
        numberOfAttendees: request.numberOfAttendees,
        
        serviceIds: request.serviceIds,
                bookingType: request.bookingType, 

      );

      final results = await remoteDataSource.searchHalls(requestModel);
      
      // Now toEntity() is available directly on HallBookingModel
      return results.map((model) => model.toEntity()).toList();
    } on ServerException catch (e) {
      throw HallBookingFailure(message: e.message);
    }
  }
  @override
  Future<List<ServiceEntity>> getServices() async {
    try {
      final results = await remoteDataSource.getServices();
      return results.map((model) => model.toEntity()).toList();
    } on ServerException catch (e) {
      throw HallBookingFailure(message: e.message);
    }
  }
   @override
  Future<BookingResponseEntity> createBooking(BookingCreateEntity booking) async {
    try {
      final bookingModel = BookingCreateModel(
        hall: booking.hall,
        date: booking.date,
        startTime: booking.startTime,
        endTime: booking.endTime,
        bookingType: booking.bookingType,
        headcount: booking.headcount,
      );

      final response = await remoteDataSource.createBooking(bookingModel);
      return response.toEntity();
    } on ServerException catch (e) {
      throw HallBookingFailure(message: e.message);
    }
  }
}