// domain/usecases/toggle_wishlist.dart
import '../repositories/wishlist_repository.dart';

class ToggleWishlist {
  final WishlistRepository repository;

  ToggleWishlist(this.repository);

  Future<void> call(int courseId) async {
    return await repository.toggleWishlist(courseId);
  }
}
