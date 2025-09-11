// bloc/loyalty_points_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../errors/failures.dart';
import '../../domain/usecases/get_loyalty_points.dart';
import 'loyalty_points_event.dart';
import 'loyalty_points_state.dart';

class LoyaltyPointsBloc extends Bloc<LoyaltyPointsEvent, LoyaltyPointsState> {
  final GetLoyaltyPoints getLoyaltyPoints;

  LoyaltyPointsBloc({required this.getLoyaltyPoints}) : super(LoyaltyPointsInitial()) {
    on<GetLoyaltyPointsEvent>(_onGetLoyaltyPoints);
    on<RefreshLoyaltyPointsEvent>(_onRefreshLoyaltyPoints);
  }

  Future<void> _onGetLoyaltyPoints(
      GetLoyaltyPointsEvent event,
      Emitter<LoyaltyPointsState> emit,
      ) async {
    emit(LoyaltyPointsLoading());
    await _fetchLoyaltyPoints(emit);
  }

  Future<void> _onRefreshLoyaltyPoints(
      RefreshLoyaltyPointsEvent event,
      Emitter<LoyaltyPointsState> emit,
      ) async {
    await _fetchLoyaltyPoints(emit);
  }

  Future<void> _fetchLoyaltyPoints(Emitter<LoyaltyPointsState> emit) async {
    try {
      final loyaltyPoints = await getLoyaltyPoints();
      emit(LoyaltyPointsLoaded(loyaltyPoints: loyaltyPoints));
    } on ServerFailure catch (_) {
      emit(const LoyaltyPointsError(message: 'Server error. Please try again later.'));
    } on UnauthorizedFailure catch (_) {
      emit(const LoyaltyPointsError(message: 'You are not authorized. Please login again.'));
    } on NotFoundFailure catch (failure) {
      emit(LoyaltyPointsError(message: failure.message));
    } on HttpFailure catch (_) {
      emit(const LoyaltyPointsError(message: 'Network error. Please check your connection.'));
    } on DataFormatFailure catch (_) {
      emit(const LoyaltyPointsError(message: 'Data format error. Please try again.'));
    } catch (e) {
      emit(const LoyaltyPointsError(message: 'An unexpected error occurred.'));
    }
  }
}