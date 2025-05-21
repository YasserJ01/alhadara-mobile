// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:project2/features/start/presentation/pages/start_page.dart';
// import '../bloc/onboarding_bloc.dart';
// import '../bloc/onboarding_events.dart';
// import '../bloc/onboarding_states.dart';
//
// class Onboarding extends StatelessWidget {
//   final PageController controller = PageController(initialPage: 0);
//
//   Onboarding({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(34, 31, 30, 1),
//       body: BlocBuilder<OnboardingBloc, OnboardingStates>(
//         builder: (context, state) {
//           return Stack(
//             alignment: Alignment.center,
//             children: [
//               PageView(
//                 controller: controller,
//                 onPageChanged: (value) {
//                   state.pageIndex = value;
//                   BlocProvider.of<OnboardingBloc>(context)
//                       .add(OnboardingEvents());
//                 },
//                 children: [
//                   _page(
//                     context: context,
//                     pageIndex: 0,
//                     imageUrl: 'assets/page1.png',
//                     title: 'Boost Productivity',
//                     desc:
//                         'Elevate your productivity to new heights and grow with us',
//                   ),
//                   _page(
//                     context: context,
//                     pageIndex: 1,
//                     imageUrl: 'assets/page2.png',
//                     title: 'Work Seamlessly',
//                     desc: 'Get your work done seamlessly without interruption',
//                   ),
//                   _page(
//                     context: context,
//                     pageIndex: 2,
//                     imageUrl: 'assets/page3.png',
//                     title: 'Achieve Higher Goals',
//                     desc:
//                         'By boosting your producivity we help you achieve higher goals',
//                   ),
//                 ],
//               ),
//               Positioned(
//                 bottom: 150,
//                 child: DotsIndicator(
//                   dotsCount: 3,
//                   position:
//                       BlocProvider.of<OnboardingBloc>(context).state.pageIndex,
//                   decorator: DotsDecorator(
//                     color: Colors.white.withOpacity(0.2),
//                     activeColor: Colors.white,
//                     size: const Size.square(9.0),
//                     activeSize: const Size(36.0, 9.0),
//                     activeShape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0)),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _page({
//     required pageIndex,
//     required imageUrl,
//     required title,
//     required desc,
//     required BuildContext context,
//   }) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(
//           imageUrl,
//         ),
//         const SizedBox(height: 40),
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 20,
//             color: Colors.white,
//           ),
//         ),
//         const SizedBox(height: 10),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 50,
//           ),
//           child: Text(
//             desc,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         const SizedBox(height: 120),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40),
//           child: Row(
//             mainAxisAlignment: pageIndex == 2
//                 ? MainAxisAlignment.center
//                 : MainAxisAlignment.spaceBetween,
//             children: [
//               Visibility(
//                 visible: pageIndex !=
//                     2, // don't show on page with index 2 (last page)
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) {
//                       return const StartPage();
//                     }));
//                   },
//                   child: Text(
//                     'Skip',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.normal,
//                       color: Colors.white.withOpacity(0.5),
//                     ),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   pageIndex == 2
//                       ? Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                           return const StartPage();
//                         }))
//                       : controller.animateToPage(pageIndex + 1,
//                           duration: const Duration(milliseconds: 500),
//                           curve: Curves.decelerate);
//                 },
//                 child: pageIndex == 2
//                     ? Container(
//                         width: 150,
//                         height: 50,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: const Color.fromRGBO(239, 137, 95, 1),
//                           borderRadius: BorderRadius.circular(18),
//                         ),
//                         child: const Text(
//                           'Get Started',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       )
//                     : Container(
//                         width: 60,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: const Color.fromRGBO(239, 137, 95, 1),
//                           borderRadius: BorderRadius.circular(18),
//                         ),
//                         child: const Icon(
//                           Icons.arrow_forward_ios_rounded,
//                           color: Colors.white,
//                         ),
//                       ),
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:alhadara/features/onboarding/widgets/onboarding_single_page.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_events.dart';
import '../bloc/onboarding_states.dart';

class Onboarding extends StatelessWidget {
  final PageController controller = PageController(initialPage: 0);

  Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<OnboardingBloc, OnboardingStates>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              PageView(
                controller: controller,
                onPageChanged: (value) {
                  state.pageIndex = value;
                  BlocProvider.of<OnboardingBloc>(context)
                      .add(OnboardingEvents());
                },
                children: [
                  OnBoardingSinglePage(
                      0,
                      'assets/img_7.png',
                      'ACCESS YOUR COURSES ANYTIME',
                      'Study at your own pace with full access to your learning materials, anytime and anywhere.',
                      context,
                      Color.fromRGBO(214, 0, 27, 1.0),
                      controller),
                  // OnboardingSinglePage(
                  //   context: context,
                  //   pageIndex: 0,
                  //   imageUrl: 'assets/img_7.png',
                  //   title: 'ACCESS YOUR COURSES ANYTIME',
                  //   desc:
                  //       'Study at your own pace with full access to your learning materials, anytime and anywhere.',
                  //   containerColor: Color.fromRGBO(214, 0, 27, 1.0),
                  // ),
                  OnBoardingSinglePage(
                    1,
                    'assets/img_1.png',
                    'Work Seamlessly',
                    'Get your work done seamlessly without interruption',
                    context,
                    Color.fromRGBO(214, 0, 27, 1.0),
                    controller,
                  ),
                  // _page(
                  //   context: context,
                  //   pageIndex: 1,
                  //   imageUrl: 'assets/img_1.png',
                  //   title: 'Work Seamlessly',
                  //   desc: 'Get your work done seamlessly without interruption',
                  //   containerColor: Color.fromRGBO(214, 0, 27, 1.0),
                  // ),
                  OnBoardingSinglePage(
                    2,
                    'assets/img_3.png',
                    'Achieve Higher Goals',
                    'By boosting your producivity we help you achieve higher goals',
                    context,
                    Color.fromRGBO(214, 0, 27, 1.0),
                    controller,
                  ),
                  // _page(
                  //   context: context,
                  //   pageIndex: 2,
                  //   imageUrl: 'assets/img_3.png',
                  //   title: 'Achieve Higher Goals',
                  //   desc:
                  //       'By boosting your producivity we help you achieve higher goals',
                  //   containerColor: Color.fromRGBO(214, 0, 27, 1.0),
                  // ),
                ],
              ),
              Positioned(
                bottom: 200,
                child: DotsIndicator(
                  dotsCount: 3,
                  position: BlocProvider.of<OnboardingBloc>(context)
                      .state
                      .pageIndex,
                  decorator: DotsDecorator(
                    color: Color.fromRGBO(214, 0, 27, 0.2),
                    activeColor: Color.fromRGBO(214, 0, 27, 1.0),
                    size: const Size.square(9.0),
                    activeSize: const Size(36.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

// Widget _page({
//   required int pageIndex,
//   required String imageUrl,
//   required String title,
//   required String desc,
//   required BuildContext context,
//   required Color containerColor,
// }) {
//   return Padding(
//     padding: EdgeInsets.only(top: AppSizes.screenHeight(context) * 0.15),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       // crossAxisAlignment: CrossAxisAlignment.,
//       children: [
//         // Container(
//         //   width: double.infinity,
//         //   height: MediaQuery.of(context).size.height * 0.30,
//         //   // margin: const EdgeInsets.symmetric(horizontal: 40),
//         //   decoration: BoxDecoration(
//         //     color: containerColor,
//         // borderRadius: const BorderRadius.only(
//         //   topLeft: Radius.circular(300),
//         //   bottomLeft: Radius.circular(300),
//         // ),
//         //   borderRadius: pageIndex == 2
//         //       ? const BorderRadius.only(
//         //           topRight: Radius.circular(300),
//         //           bottomRight: Radius.circular(300),
//         //         )
//         //       : pageIndex == 0
//         //           ? const BorderRadius.only(
//         //               topLeft: Radius.circular(300),
//         //               bottomLeft: Radius.circular(300),
//         //             )
//         //           : BorderRadius.circular(0),
//         // ),
//         // borderRadius: BorderRadius.circular(0),
//         Center(
//           child: Image.asset(
//             imageUrl,
//             // fit: BoxFit.contain,
//             // height: MediaQuery.of(context).size.height * 0.30,
//             width: double.infinity,
//           ),
//         ),
//         // ),
//         const SizedBox(height: 30),
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Color.fromRGBO(214, 0, 27, 1.0),
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 10),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 50,
//           ),
//           child: Text(
//             desc,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Color.fromRGBO(214, 0, 27, 1.0),
//             ),
//           ),
//         ),
//         pageIndex == 1
//             ? const SizedBox(height: 40)
//             : pageIndex == 0
//                 ? const SizedBox(height: 1)
//                 : const SizedBox(height: 72),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40),
//           /*child: pageIndex == 2
//               ?*/
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 50,
//               ),
//               OnBoardingButton(
//                   label: 'NEXT',
//                   onTap: () {
//                     pageIndex == 2
//                         ? Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (context) {
//                             return const StartPage();
//                           }))
//                         : controller.animateToPage(pageIndex + 1,
//                             duration: const Duration(milliseconds: 500),
//                             curve: Curves.decelerate);
//                   },
//                   backgroundColor: Color.fromRGBO(214, 0, 27, 1.0),
//                   textColor: Colors.white,
//                   context: context),
//               const SizedBox(height: 15),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return const StartPage();
//                   }));
//                 },
//                 child: const Text(
//                   'Skip Tour',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Color.fromRGBO(214, 0, 27, 1.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // Row(
//         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //     children: [
//         //       GestureDetector(
//         //         onTap: () {
//         //           Navigator.of(context)
//         //               .push(MaterialPageRoute(builder: (context) {
//         //             return const StartPage();
//         //           }));
//         //         },
//         //         child: Text(
//         //           'Skip',
//         //           textAlign: TextAlign.center,
//         //           style: TextStyle(
//         //             fontSize: 15,
//         //             fontWeight: FontWeight.normal,
//         //             color: Colors.red,
//         //           ),
//         //         ),
//         //       ),
//         //       GestureDetector(
//         //         onTap: () {
//         //           controller.animateToPage(pageIndex + 1,
//         //               duration: const Duration(milliseconds: 500),
//         //               curve: Curves.decelerate);
//         //         },
//         //         child: Container(
//         //           width: 60,
//         //           height: 50,
//         //           decoration: BoxDecoration(
//         //             // color: const Color.fromRGBO(239, 137, 95, 1),
//         //             color:Colors.red,
//         //             borderRadius: BorderRadius.circular(18),
//         //           ),
//         //           child: const Icon(
//         //             Icons.arrow_forward_ios_rounded,
//         //             color: Colors.white,
//         //           ),
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//       ],
//     ),
//   );
// }
}
