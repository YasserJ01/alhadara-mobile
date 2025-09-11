// bloc/loyalty_points_event.dart
import 'package:equatable/equatable.dart';

abstract class LoyaltyPointsEvent extends Equatable {
  const LoyaltyPointsEvent();

  @override
  List<Object> get props => [];
}

class GetLoyaltyPointsEvent extends LoyaltyPointsEvent {}

class RefreshLoyaltyPointsEvent extends LoyaltyPointsEvent {}
