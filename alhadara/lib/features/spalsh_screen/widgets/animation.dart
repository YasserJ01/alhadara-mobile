import 'package:alhadara/core/constants/app_size.dart';
import 'package:flutter/material.dart';

class GradientRevealAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback onComplete;
  
  const GradientRevealAnimation({
    super.key,
    required this.child,
    required this.onComplete,
  });

  @override
  _GradientRevealAnimationState createState() => _GradientRevealAnimationState();
}

// class _GradientRevealAnimationState extends State<GradientRevealAnimation> 
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
    
//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           widget.onComplete();
//         }
//       });

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Opacity(
//           opacity: _animation.value,
//           child: widget.child,
//         );
//       },
//     );
//   }
// }
class _GradientRevealAnimationState extends State<GradientRevealAnimation> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Duration _animationDuration;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Default value, will be updated
    );
    
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete();
        }
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenWidth = AppSizes.screenWidth(context);
    _animationDuration = Duration(
      milliseconds: screenWidth < 600 ? 1500 : 2000
    );
    _controller.duration = _animationDuration;
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: SizedBox(
            width: AppSizes.screenWidth(context) * 0.8,
            height: AppSizes.screenHeight(context) * 0.5,
            child: widget.child,
          ),
        );
      },
    );
  }
}