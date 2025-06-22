// presentation/pages/wishlist_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_scaffold.dart';
import '../bloc/wishlist_bloc.dart';
import '../bloc/wishlist_event.dart';
import '../bloc/wishlist_state.dart';
import '../../domain/entities/wishlist.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Wishlist',
      edgeInsets: const EdgeInsets.all(0),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistInitial) {
            // Load wishlists when page is first built
            context.read<WishlistBloc>().add(LoadWishlistsEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistLoaded) {
            if (state.wishlists.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No courses in your wishlist yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Start adding courses you love!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<WishlistBloc>().add(LoadWishlistsEvent());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _getTotalCourses(state.wishlists),
                itemBuilder: (context, index) {
                  final courseData = _getCourseAtIndex(state.wishlists, index);
                  return _buildCourseCard(courseData);
                },
              ),
            );
          } else if (state is WishlistError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 80,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Failed to load wishlist',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WishlistBloc>().add(LoadWishlistsEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  int _getTotalCourses(List<Wishlist> wishlists) {
    return wishlists.fold(
        0, (total, wishlist) => total + wishlist.courses.length);
  }

  Map<String, String> _getCourseAtIndex(List<Wishlist> wishlists, int index) {
    int currentIndex = 0;
    for (final wishlist in wishlists) {
      for (final course in wishlist.courses) {
        if (currentIndex == index) {
          return {
            'title': course.title,
            'courseTypeName': course.courseTypeName,
          };
        }
        currentIndex++;
      }
    }
    return {'title': '', 'courseTypeName': ''};
  }

  Widget _buildCourseCard(Map<String, String> courseData) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseData['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(162, 12, 13, 1.0),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      courseData['courseTypeName'] ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
