// domain/usecases/get_wishlists.dart
import '../entities/wishlist.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlists {
  final WishlistRepository repository;

  GetWishlists(this.repository);

  Future<List<Wishlist>> call() async {
    return await repository.getWishlists();
  }
}