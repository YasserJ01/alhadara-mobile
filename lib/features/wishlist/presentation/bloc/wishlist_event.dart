
// presentation/bloc/wishlist_event.dart
import 'package:equatable/equatable.dart';

abstract class WishlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleWishlistEvent extends WishlistEvent {
  final int courseId;

  ToggleWishlistEvent(this.courseId);

  @override
  List<Object> get props => [courseId];
}

class LoadWishlistsEvent extends WishlistEvent {}