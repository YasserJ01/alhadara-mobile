import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../wishlist/presentation/bloc/wishlist_bloc.dart';
import '../../../wishlist/presentation/bloc/wishlist_event.dart';
import '../../../wishlist/presentation/bloc/wishlist_state.dart';

// New StatefulWidget for the wishlist button
class WishlistButton extends StatefulWidget {
  final int courseId;
  final bool initialIsWishlisted;

  const WishlistButton({
    required this.courseId,
    required this.initialIsWishlisted,
  });

  @override
  _WishlistButtonState createState() => _WishlistButtonState();
}

class _WishlistButtonState extends State<WishlistButton> {
  late bool _isWishlisted;

  @override
  void initState() {
    super.initState();
    _isWishlisted = widget.initialIsWishlisted;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      listener: (context, state) {
        if (state is WishlistToggleSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wishlist updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is WishlistToggleError) {
          // Revert the state if there was an error
          setState(() {
            _isWishlisted = !_isWishlisted;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to update wishlist'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return IconButton(
          onPressed: state is WishlistLoading
              ? null
              : () {
            // Update the UI immediately
            setState(() {
              _isWishlisted = !_isWishlisted;
            });
            // Then send the event to the bloc
            context.read<WishlistBloc>().add(
              ToggleWishlistEvent(widget.courseId),
            );
          },
          icon: state is WishlistLoading
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              : _isWishlisted
              ? const Icon(
            Icons.favorite,
            color: Color.fromRGBO(162, 12, 13, 1.0),
            size: 28,
          )
              : const Icon(
            Icons.favorite_border,
            color: Color.fromRGBO(162, 12, 13, 1.0),
            size: 28,
          ),
        );
      },
    );
  }
}