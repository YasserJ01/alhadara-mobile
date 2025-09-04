import 'package:alhadara/errors/expections.dart';
import 'package:alhadara/features/hall_services/domain/usecases/create_booking_usecase.dart.dart';
import 'package:alhadara/features/hall_services/domain/usecases/get_services_usecase.dart';
import 'package:alhadara/features/hall_services/domain/usecases/search_halls_usecase.dart';
import 'package:alhadara/features/hall_services/presentation/bloc/hall_booking_event.dart';
import 'package:alhadara/features/hall_services/presentation/bloc/hall_booking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HallBookingBloc extends Bloc<HallBookingEvent, HallBookingState> {
  final SearchHallsUseCase searchHallsUseCase;
  final GetServicesUseCase getServicesUseCase;
  final CreateBookingUseCase createBookingUseCase;

  HallBookingBloc({
    required this.searchHallsUseCase,
    required this.getServicesUseCase,
    required this.createBookingUseCase,
  }) : super(HallBookingInitial()) {
    on<SearchHallsEvent>(_onSearchHalls);
    on<LoadServicesEvent>(_onLoadServices);
    on<CreateBookingEvent>(_onCreateBooking);
  }

  Future<void> _onSearchHalls(
    SearchHallsEvent event,
    Emitter<HallBookingState> emit,
  ) async {
    emit(HallBookingLoading());
    
    try {
      final halls = await searchHallsUseCase(event.request);
      emit(HallBookingLoaded(halls: halls,searchRequest: event.request));
    } on HallBookingFailure catch (e) {
      emit(HallBookingError(message: e.message));
    } catch (e) {
      emit(HallBookingError(message: 'An unexpected error occurred: $e'));
    }
  }

  Future<void> _onLoadServices(
    LoadServicesEvent event,
    Emitter<HallBookingState> emit,
  ) async {
    emit(ServicesLoading());
    
    try {
      final services = await getServicesUseCase();
      emit(ServicesLoaded(services: services));
    } on HallBookingFailure catch (e) {
      emit(ServicesError(message: e.message));
    } catch (e) {
      emit(ServicesError(message: 'Failed to load services: $e'));
    }
  }

  Future<void> _onCreateBooking(
    CreateBookingEvent event,
    Emitter<HallBookingState> emit,
  ) async {
    emit(BookingCreating());
    
    try {
      final booking = await createBookingUseCase(event.booking);
      emit(BookingCreated(booking: booking));
    } on HallBookingFailure catch (e) {
      emit(BookingCreationError(message: e.message));
    } catch (e) {
      emit(BookingCreationError(message: 'Failed to create booking: $e'));
    }
  }
}