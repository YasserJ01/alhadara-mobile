// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:dots_indicator/dots_indicator.dart';
// // import 'package:project2/features/start/presentation/pages/start_page.dart';
// // import '../bloc/onboarding_bloc.dart';
// // import '../bloc/onboarding_events.dart';
// // import '../bloc/onboarding_states.dart';
// //
// // class Onboarding extends StatelessWidget {
// //   final PageController controller = PageController(initialPage: 0);
// //
// //   Onboarding({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color.fromRGBO(34, 31, 30, 1),
// //       body: BlocBuilder<OnboardingBloc, OnboardingStates>(
// //         builder: (context, state) {
// //           return Stack(
// //             alignment: Alignment.center,
// //             children: [
// //               PageView(
// //                 controller: controller,
// //                 onPageChanged: (value) {
// //                   state.pageIndex = value;
// //                   BlocProvider.of<OnboardingBloc>(context)
// //                       .add(OnboardingEvents());
// //                 },
// //                 children: [
// //                   _page(
// //                     context: context,
// //                     pageIndex: 0,
// //                     imageUrl: 'assets/page1.png',
// //                     title: 'Boost Productivity',
// //                     desc:
// //                         'Elevate your productivity to new heights and grow with us',
// //                   ),
// //                   _page(
// //                     context: context,
// //                     pageIndex: 1,
// //                     imageUrl: 'assets/page2.png',
// //                     title: 'Work Seamlessly',
// //                     desc: 'Get your work done seamlessly without interruption',
// //                   ),
// //                   _page(
// //                     context: context,
// //                     pageIndex: 2,
// //                     imageUrl: 'assets/page3.png',
// //                     title: 'Achieve Higher Goals',
// //                     desc:
// //                         'By boosting your producivity we help you achieve higher goals',
// //                   ),
// //                 ],
// //               ),
// //               Positioned(
// //                 bottom: 150,
// //                 child: DotsIndicator(
// //                   dotsCount: 3,
// //                   position:
// //                       BlocProvider.of<OnboardingBloc>(context).state.pageIndex,
// //                   decorator: DotsDecorator(
// //                     color: Colors.white.withOpacity(0.2),
// //                     activeColor: Colors.white,
// //                     size: const Size.square(9.0),
// //                     activeSize: const Size(36.0, 9.0),
// //                     activeShape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(5.0)),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _page({
// //     required pageIndex,
// //     required imageUrl,
// //     required title,
// //     required desc,
// //     required BuildContext context,
// //   }) {
// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: [
// //         Image.asset(
// //           imageUrl,
// //         ),
// //         const SizedBox(height: 40),
// //         Text(
// //           title,
// //           style: const TextStyle(
// //             fontSize: 20,
// //             color: Colors.white,
// //           ),
// //         ),
// //         const SizedBox(height: 10),
// //         Padding(
// //           padding: const EdgeInsets.symmetric(
// //             horizontal: 50,
// //           ),
// //           child: Text(
// //             desc,
// //             textAlign: TextAlign.center,
// //             style: const TextStyle(
// //               fontSize: 12,
// //               color: Colors.white,
// //             ),
// //           ),
// //         ),
// //         const SizedBox(height: 120),
// //         Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 40),
// //           child: Row(
// //             mainAxisAlignment: pageIndex == 2
// //                 ? MainAxisAlignment.center
// //                 : MainAxisAlignment.spaceBetween,
// //             children: [
// //               Visibility(
// //                 visible: pageIndex !=
// //                     2, // don't show on page with index 2 (last page)
// //                 child: GestureDetector(
// //                   onTap: () {
// //                     Navigator.of(context)
// //                         .push(MaterialPageRoute(builder: (context) {
// //                       return const StartPage();
// //                     }));
// //                   },
// //                   child: Text(
// //                     'Skip',
// //                     textAlign: TextAlign.center,
// //                     style: TextStyle(
// //                       fontSize: 15,
// //                       fontWeight: FontWeight.normal,
// //                       color: Colors.white.withOpacity(0.5),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               GestureDetector(
// //                 onTap: () {
// //                   pageIndex == 2
// //                       ? Navigator.of(context)
// //                           .push(MaterialPageRoute(builder: (context) {
// //                           return const StartPage();
// //                         }))
// //                       : controller.animateToPage(pageIndex + 1,
// //                           duration: const Duration(milliseconds: 500),
// //                           curve: Curves.decelerate);
// //                 },
// //                 child: pageIndex == 2
// //                     ? Container(
// //                         width: 150,
// //                         height: 50,
// //                         alignment: Alignment.center,
// //                         decoration: BoxDecoration(
// //                           color: const Color.fromRGBO(239, 137, 95, 1),
// //                           borderRadius: BorderRadius.circular(18),
// //                         ),
// //                         child: const Text(
// //                           'Get Started',
// //                           textAlign: TextAlign.center,
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.white,
// //                           ),
// //                         ),
// //                       )
// //                     : Container(
// //                         width: 60,
// //                         height: 50,
// //                         decoration: BoxDecoration(
// //                           color: const Color.fromRGBO(239, 137, 95, 1),
// //                           borderRadius: BorderRadius.circular(18),
// //                         ),
// //                         child: const Icon(
// //                           Icons.arrow_forward_ios_rounded,
// //                           color: Colors.white,
// //                         ),
// //                       ),
// //               )
// //             ],
// //           ),
// //         )
// //       ],
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:project2/features/onboarding/widgets/onboarding_single_page.dart';
// import '../bloc/onboarding_bloc.dart';
// import '../bloc/onboarding_events.dart';
// import '../bloc/onboarding_states.dart';
//
// class Onboarding extends StatefulWidget {
//   const Onboarding({super.key});
//
//   @override
//   State<Onboarding> createState() => _OnboardingState();
// }
//
// class _OnboardingState extends State<Onboarding> {
//   final PageController controller = PageController(initialPage: 0);
//   int currentPageIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     // Check onboarding status when the widget initializes
//     context.read<OnboardingBloc>().add(CheckOnboardingStatus());
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   void _completeOnboarding() {
//     context.read<OnboardingBloc>().add(OnboardingCompleted());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: BlocConsumer<OnboardingBloc, OnboardingStates>(
//         listener: (context, state) {
//           if (state is OnboardingHide) {
//             // Navigate to the main app screen
//             Navigator.of(context).pushReplacementNamed('/departments');
//             // Or use your preferred navigation method:
//             // Navigator.of(context).pushReplacement(
//             //   MaterialPageRoute(builder: (context) => const DepartmentsPage()),
//             // );
//           } else if (state is OnboardingError) {
//             // Handle error - you might want to show a snackbar or dialog
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is OnboardingLoading) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: Color.fromRGBO(214, 0, 27, 1.0),
//               ),
//             );
//           }
//
//           if (state is OnboardingShow) {
//             return Stack(
//               alignment: Alignment.center,
//               children: [
//                 PageView(
//                   controller: controller,
//                   onPageChanged: (value) {
//                     setState(() {
//                       currentPageIndex = value;
//                     });
//                     context.read<OnboardingBloc>().add(OnboardingPageChanged(value));
//                   },
//                   children: [
//                     OnboardingSinglePage(
//                       pageIndex: 0,
//                       imageUrl: 'assets/img_7.png',
//                       title: 'ACCESS YOUR COURSES ANYTIME',
//                       desc: 'Study at your own pace with full access to your learning materials, anytime and anywhere.',
//                       containerColor: const Color.fromRGBO(214, 0, 27, 1.0),
//                       controller: controller,
//                       onComplete: _completeOnboarding,
//                     ),
//                     OnboardingSinglePage(
//                       pageIndex: 1,
//                       imageUrl: 'assets/img_1.png',
//                       title: 'Work Seamlessly',
//                       desc: 'Get your work done seamlessly without interruption',
//                       containerColor: const Color.fromRGBO(214, 0, 27, 1.0),
//                       controller: controller,
//                       onComplete: _completeOnboarding,
//                     ),
//                     OnboardingSinglePage(
//                       pageIndex: 2,
//                       imageUrl: 'assets/img_3.png',
//                       title: 'Achieve Higher Goals',
//                       desc: 'By boosting your productivity we help you achieve higher goals',
//                       containerColor: const Color.fromRGBO(214, 0, 27, 1.0),
//                       controller: controller,
//                       onComplete: _completeOnboarding,
//                     ),
//                   ],
//                 ),
//                 Positioned(
//                   bottom: 200,
//                   child: DotsIndicator(
//                     dotsCount: 3,
//                     position: currentPageIndex,
//                     decorator: const DotsDecorator(
//                       color: Color.fromRGBO(214, 0, 27, 0.2),
//                       activeColor: Color.fromRGBO(214, 0, 27, 1.0),
//                       size: Size.square(9.0),
//                       activeSize: Size(36.0, 9.0),
//                       activeShape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }
//
//           // For OnboardingHide state or any other state, show empty container
//           // Navigation will be handled in the listener
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
