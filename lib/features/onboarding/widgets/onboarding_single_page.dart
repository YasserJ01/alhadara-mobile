import 'package:flutter/material.dart';

import '../../../core/constants/app_size.dart';
import '../../courses/presentation/pages/departments_page.dart';
import 'onboarding_buttons.dart';

class OnboardingSinglePage extends StatelessWidget {
  final int pageIndex;
  final String imageUrl;
  final String title;
  final String desc;
  final Color containerColor;
  final PageController controller;
  final VoidCallback onComplete;

  const OnboardingSinglePage({
    super.key,
    required this.pageIndex,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.containerColor,
    required this.controller,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: AppSizes.screenHeight(context) * 0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
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
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(214, 0, 27, 1.0),
                ),
              ),
            ),
            SizedBox(
              height: pageIndex == 1
                  ? 40
                  : pageIndex == 0
                  ? 1
                  : 72,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  OnBoardingButton(
                    label: pageIndex == 2 ? 'GET STARTED' : 'NEXT',
                    onTap: () {
                      if (pageIndex == 2) {
                        onComplete();
                      } else {
                        controller.animateToPage(
                          pageIndex + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate,
                        );
                      }
                    },
                    backgroundColor: const Color.fromRGBO(214, 0, 27, 1.0),
                    textColor: Colors.white,
                    context: context,
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: onComplete,
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
          ],
        ),
      ),
    );
  }
}
