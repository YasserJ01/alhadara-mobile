import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../../localization/app_localizations.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_events.dart';
import '../bloc/onboarding_states.dart';
import 'onboarding_button.dart';
import 'onboarding_page.dart';

class OnboardingView extends StatefulWidget {
  final int pageIndex;

  const OnboardingView({required this.pageIndex});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _completeOnboarding() {
    context.read<OnboardingBloc>().add(CompleteOnboardingEvent());
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    final titles = [
      locale.onboardingTitle1,
      locale.onboardingTitle2,
      locale.onboardingTitle3,
    ];

    final descriptions = [
      locale.onboardingDesc1,
      locale.onboardingDesc2,
      locale.onboardingDesc3,
    ];

    final images = [
      'assets/img_7.png',
      'assets/img_1.png',
      'assets/img_3.png',
    ];
    return Stack(
      alignment: Alignment.center,
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (index) {
            context
                .read<OnboardingBloc>()
                .add(UpdateOnboardingPageEvent(index));
          },
          children:  [
            OnboardingPage(
              imageAsset: 'assets/img_7.png',
              title: locale.onboardingTitle1!,
              description:
              locale.onboardingDesc1!,
            ),
            OnboardingPage(
              imageAsset: 'assets/img_1.png',
              title: locale.onboardingTitle2!,
              description: locale.onboardingDesc2!,
            ),
            OnboardingPage(
              imageAsset: 'assets/img_3.png',
              title: locale.onboardingTitle3!,
              description:
              locale.onboardingDesc3!,
            ),
          ],
        ),
        Positioned(
          bottom: 200,
          child: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              final currentIndex =
                  state is OnboardingInProgress ? state.pageIndex : 0;
              return DotsIndicator(
                dotsCount: 3,
                position: currentIndex,
                decorator: const DotsDecorator(
                  color: Color.fromRGBO(214, 0, 27, 0.2),
                  activeColor: Color.fromRGBO(214, 0, 27, 1.0),
                  size: Size.square(9.0),
                  activeSize: Size(36.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 100,
          left: 40,
          right: 40,
          child: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              final currentIndex =
                  state is OnboardingInProgress ? state.pageIndex : 0;
              return Column(
                children: [
                  OnboardingButton(
                    text: currentIndex == 2 ? 'GET STARTED' : 'NEXT',
                    onPressed: () {
                      if (currentIndex == 2) {
                        _completeOnboarding();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  if (currentIndex != 2)
                    TextButton(
                      onPressed: _completeOnboarding,
                      child:  Text(
                        locale.skipButton!,
                        style: const TextStyle(
                          color: Color.fromRGBO(214, 0, 27, 1.0),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
