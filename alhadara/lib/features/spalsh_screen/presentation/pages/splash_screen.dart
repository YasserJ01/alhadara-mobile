
import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../start/presentation/pages/start_page.dart';
import '../../widgets/animation.dart';
import '../../widgets/dots_animation.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SplashBloc()..add(SplashStarted()),
//       child: BlocListener<SplashBloc, SplashState>(
//         listener: (context, state) {
//           if (state is SplashComplete) {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(builder: (_) => const StartPage()),
//             );
//           }
//         },
//         child: Scaffold(
//           backgroundColor: const Color.fromRGBO(162, 12, 13, 1.0),
//           body: Center(
//             child: BlocBuilder<SplashBloc, SplashState>(
//               builder: (context, state) {
//                 if (state is SplashAnimationRunning) {
//                   return GradientRevealAnimation(
//                     onComplete: () => context
//                         .read<SplashBloc>()
//                         .add(SplashAnimationComplete()),
//                     child: Image.asset('assets/logo.png'),
//                   );
//                 } else if (state is ShowDotsAnimation) {
//                   return DotsAnimation(
//                     onComplete: () => context
//                         .read<SplashBloc>()
//                         .add(DotsAnimationComplete()),
//                   );
//                 }
//                 return const SizedBox();
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
          backgroundColor: AppColors.mainColor,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.responsiveSize(context, 
                      mobile: 16.0, tablet: 32.0, desktop: 64.0)),
                child: BlocBuilder<SplashBloc, SplashState>(
                  builder: (context, state) {
                    if (state is SplashAnimationRunning) {
                      return GradientRevealAnimation(
                        onComplete: () => context
                            .read<SplashBloc>()
                            .add(SplashAnimationComplete()),
                        child: Image.asset(
                          'assets/logo.png',
                          width: AppSizes.screenWidth(context) * 0.7,
                          height: AppSizes.screenHeight(context) * 0.4,
                          fit: BoxFit.contain,
                        ),
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
        ),
      ),
    );
  }
}