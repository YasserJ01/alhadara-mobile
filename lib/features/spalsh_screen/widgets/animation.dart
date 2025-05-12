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

class _GradientRevealAnimationState extends State<GradientRevealAnimation> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete();
        }
      });

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
          child: widget.child,
        );
      },
    );
  }
}