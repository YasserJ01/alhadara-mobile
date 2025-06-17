// domain/repositories/wishlist_repository.dart
import '../entities/wishlist.dart';

abstract class WishlistRepository {
  Future<void> toggleWishlist(int courseId);
  Future<List<Wishlist>> getWishlists();
}