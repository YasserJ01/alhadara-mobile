import 'package:flutter/material.dart';

import '../../../core/constants/app_size.dart';
import '../../courses/presentation/pages/departments_page.dart';
import 'onboarding_buttons.dart';
class OnboardingSinglePage extends StatelessWidget {
  int pageIndex;
  String imageUrl;
  String title;
  String desc;
  BuildContext context;
  Color containerColor;
  PageController pageController;

  OnboardingSinglePage(this.pageIndex, this.imageUrl, this.title, this.desc,
      this.context, this.containerColor,this.pageController);


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: AppSizes.screenHeight(context) * 0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.,
          children: [
            // Container(
            //   width: double.infinity,
            //   height: MediaQuery.of(context).size.height * 0.30,
            //   // margin: const EdgeInsets.symmetric(horizontal: 40),
            //   decoration: BoxDecoration(
            //     color: containerColor,
            // borderRadius: const BorderRadius.only(
            //   topLeft: Radius.circular(300),
            //   bottomLeft: Radius.circular(300),
            // ),
            //   borderRadius: pageIndex == 2
            //       ? const BorderRadius.only(
            //           topRight: Radius.circular(300),
            //           bottomRight: Radius.circular(300),
            //         )
            //       : pageIndex == 0
            //           ? const BorderRadius.only(
            //               topLeft: Radius.circular(300),
            //               bottomLeft: Radius.circular(300),
            //             )
            //           : BorderRadius.circular(0),
            // ),
            // borderRadius: BorderRadius.circular(0),
            Center(
              child: Image.asset(
                imageUrl,
                // fit: BoxFit.contain,
                // height: MediaQuery.of(context).size.height * 0.30,
                width: double.infinity,
              ),
            ),
            // ),
            const SizedBox(height: 30),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(214, 0, 27, 1.0),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(214, 0, 27, 1.0),
                ),
              ),
            ),
            pageIndex == 1
                ? const SizedBox(height: 40)
                : pageIndex == 0
                ? const SizedBox(height: 1)
                : const SizedBox(height: 72),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              /*child: pageIndex == 2
                  ?*/
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  OnBoardingButton(
                    label: 'NEXT',
                    onTap: () {
                      pageIndex == 2
                          ? Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context) {
                        return const DepartmentsPage();
                      }))
                          : pageController.animateToPage(pageIndex + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                    },
                    backgroundColor: Color.fromRGBO(214, 0, 27, 1.0),
                    textColor: Colors.white,
                    context: context,
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context) {
                        return const DepartmentsPage();
                      }));
                    },
                    child: const Text(
                      'Skip Tour',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(214, 0, 27, 1.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           Navigator.of(context)
            //               .push(MaterialPageRoute(builder: (context) {
            //             return const StartPage();
            //           }));
            //         },
            //         child: Text(
            //           'Skip',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             fontSize: 15,
            //             fontWeight: FontWeight.normal,
            //             color: Colors.red,
            //           ),
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: () {
            //           controller.animateToPage(pageIndex + 1,
            //               duration: const Duration(milliseconds: 500),
            //               curve: Curves.decelerate);
            //         },
            //         child: Container(
            //           width: 60,
            //           height: 50,
            //           decoration: BoxDecoration(
            //             // color: const Color.fromRGBO(239, 137, 95, 1),
            //             color:Colors.red,
            //             borderRadius: BorderRadius.circular(18),
            //           ),
            //           child: const Icon(
            //             Icons.arrow_forward_ios_rounded,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
          ],
        ),
      ),
    );
  }
}

