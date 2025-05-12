
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../start/presentation/pages/start_page.dart';
import '../../widgets/animation.dart';
import '../../widgets/dots_animation.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

// Add this import

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SplashBloc()..add(SplashStarted()),
//       child: Scaffold(
//         backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
//         body: BlocListener<SplashBloc, SplashState>(
//           listener: (context, state) {
//             if (state is ShowDotsAnimation) {
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(
//                   builder: (_) => BlocProvider.value(
//                     value: BlocProvider.of<SplashBloc>(context),
//                     child: const LoadingDotsScreen(),
//                   ),
//                 ),
//               );
//             }
//             if (state is SplashComplete) {
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (_) => const StartPage()),
//               );
//             }
//           },
//           child: Center(
//             child: BlocBuilder<SplashBloc, SplashState>(
//               builder: (context, state) {
//                 return GradientRevealAnimation(
//                   onComplete: () =>
//                       context.read<SplashBloc>().add(SplashAnimationComplete()),
//                   child: Image.asset('assets/logo.png'),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashComplete) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const StartPage()),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
          body: Center(
            child: BlocBuilder<SplashBloc, SplashState>(
              builder: (context, state) {
                if (state is SplashAnimationRunning) {
                  return GradientRevealAnimation(
                    onComplete: () => context
                        .read<SplashBloc>()
                        .add(SplashAnimationComplete()),
                    child: Image.asset('assets/logo.png'),
                  );
                } else if (state is ShowDotsAnimation) {
                  return DotsAnimation(
                    onComplete: () => context
                        .read<SplashBloc>()
                        .add(DotsAnimationComplete()),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}