import 'package:alhadara/core/constants/app_size.dart';
import 'package:flutter/material.dart';

class DotsAnimation extends StatefulWidget {
  final VoidCallback onComplete;

  const DotsAnimation({super.key, required this.onComplete});

  @override
  _DotsAnimationState createState() => _DotsAnimationState();
}

// class _DotsAnimationState extends State<DotsAnimation> with TickerProviderStateMixin {
//   late List<AnimationController> _controllers;
//   late List<Animation<double>> _animations;

//   @override
//   void initState() {
//     super.initState();
//     _controllers = List.generate(3, (index) =>
//       AnimationController(
//         vsync: this,
//         duration: Duration(milliseconds: 500),
//       )..repeat(reverse: true)
//     );

//     _animations = _controllers.map((controller) =>
//       Tween<double>(begin: 6, end: 12).animate(controller)
//     ).toList();

//     // Start animations with delay
//     for (int i = 0; i < _controllers.length; i++) {
//       Future.delayed(Duration(milliseconds: i * 200), () {
//         if (mounted) _controllers[i].repeat(reverse: true);
//       });
//     }

//     // Complete after 3 seconds
//     Future.delayed(const Duration(seconds: 3), () {
//       if (mounted) {
//         widget.onComplete();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(3, (index) {
//         return AnimatedBuilder(
//           animation: _animations[index],
//           builder: (context, child) {
//             return Container(
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               width: _animations[index].value,
//               height: _animations[index].value,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.circle,
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
class _DotsAnimationState extends State<DotsAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<double> _dotSizes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
        3,
        (index) => AnimationController(
              vsync: this,
              duration: const Duration(milliseconds: 500),
            ));

    // Initialize with default values, will be updated in didChangeDependencies
    _dotSizes = List.filled(3, 6.0);
    _animations = _controllers
        .map((controller) =>
            Tween<double>(begin: 6, end: 12).animate(controller))
        .toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Now we can safely access MediaQuery
    final beginSize =
        AppSizes.responsiveSize(context, mobile: 6, tablet: 8, desktop: 10);
    final endSize =
        AppSizes.responsiveSize(context, mobile: 12, tablet: 16, desktop: 20);

    _animations = _controllers
        .map((controller) =>
            Tween<double>(begin: beginSize, end: endSize).animate(controller))
        .toList();

    // Start animations with delay
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) _controllers[i].repeat(reverse: true);
      });
    }

    // Complete after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Container(
              margin: EdgeInsets.symmetric(
                  horizontal: AppSizes.responsiveSize(context,
                      mobile: 4, tablet: 6, desktop: 8)),
              width: _animations[index].value,
              height: _animations[index].value,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }
}
