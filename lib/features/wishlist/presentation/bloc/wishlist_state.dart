// presentation/bloc/wishlist_state.dart
import 'package:equatable/equatable.dart';
import '../../../../errors/failures.dart';
import '../../domain/entities/wishlist.dart';

abstract class WishlistState extends Equatable {
  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistToggleSuccess extends WishlistState {}

class WishlistToggleError extends WishlistState {
  final Failure failure;

  WishlistToggleError(this.failure);

  @override
  List<Object> get props => [failure];
}

class WishlistLoaded extends WishlistState {
  final List<Wishlist> wishlists;

  WishlistLoaded(this.wishlists);

  @override
  List<Object> get props => [wishlists];
}

class WishlistError extends WishlistState {
  final Failure failure;

  WishlistError(this.failure);

  @override
  List<Object> get props => [failure];
}