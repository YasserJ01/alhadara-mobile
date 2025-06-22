// data/repositories/wishlist_repository_impl.dart
import '../../../../errors/failures.dart';
import '../../domain/entities/wishlist.dart';
import '../../domain/entities/wishlist_course.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_remote_datasource.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;

  WishlistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> toggleWishlist(int courseId) async {
    try {
      return await remoteDataSource.toggleWishlist(courseId);
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<List<Wishlist>> getWishlists() async {
    try {
      final wishlistModels = await remoteDataSource.getWishlists();
      return wishlistModels.map((model) {
        return Wishlist(
          id: model.id,
          owner: model.owner,
          courses: model.courses.map((course) {
            return WishlistCourse(
              title: course.title,
              courseTypeName: course.courseTypeName,
            );
          }).toList(),
          createdAt: model.createdAt,
        );
      }).toList();
    } catch (e) {
      throw ServerFailure();
    }
  }
}