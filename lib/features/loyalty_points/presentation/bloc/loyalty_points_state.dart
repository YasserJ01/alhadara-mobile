// bloc/loyalty_points_state.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/loyalty_points.dart';

abstract class LoyaltyPointsState extends Equatable {
  const LoyaltyPointsState();

  @override
  List<Object> get props => [];
}

class LoyaltyPointsInitial extends LoyaltyPointsState {}

class LoyaltyPointsLoading extends LoyaltyPointsState {}

class LoyaltyPointsLoaded extends LoyaltyPointsState {
  final LoyaltyPoints loyaltyPoints;

  const LoyaltyPointsLoaded({required this.loyaltyPoints});

  @override
  List<Object> get props => [loyaltyPoints];
}

class LoyaltyPointsError extends LoyaltyPointsState {
  final String message;

  const LoyaltyPointsError({required this.message});

  @override
  List<Object> get props => [message];
}