// presentation/bloc/wishlist_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../errors/failures.dart';
import '../../domain/usecases/toggle_wishlist.dart';
import '../../domain/usecases/get_wishlists.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final ToggleWishlist toggleWishlist;
  final GetWishlists getWishlists;

  WishlistBloc({
    required this.toggleWishlist,
    required this.getWishlists,
  }) : super(WishlistInitial()) {
    on<ToggleWishlistEvent>(_onToggleWishlist);
    on<LoadWishlistsEvent>(_onLoadWishlists);
  }

  Future<void> _onToggleWishlist(
      ToggleWishlistEvent event,
      Emitter<WishlistState> emit,
      ) async {
    emit(WishlistLoading());
    try {
      await toggleWishlist(event.courseId);
      emit(WishlistToggleSuccess());
    } catch (e) {
      if (e is Failure) {
        emit(WishlistToggleError(e));
      } else {
        emit(WishlistToggleError(ServerFailure()));
      }
    }
  }

  Future<void> _onLoadWishlists(
      LoadWishlistsEvent event,
      Emitter<WishlistState> emit,
      ) async {
    emit(WishlistLoading());
    try {
      final wishlists = await getWishlists();
      emit(WishlistLoaded(wishlists));
    } catch (e) {
      if (e is Failure) {
        emit(WishlistError(e));
      } else {
        emit(WishlistError(ServerFailure()));
      }
    }
  }
}