// onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/presentation/pages/home_page.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_events.dart';
import '../bloc/onboarding_states.dart';
import '../widgets/onboarding_view.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return const HomePage();
                },
              ),
            );
            // Navigator.pushReplacementNamed(context, '/departments');
          }
        },
        builder: (context, state) {
          if (state is OnboardingLoading || state is OnboardingInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OnboardingError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context
                        .read<OnboardingBloc>()
                        .add(CheckOnboardingStatusEvent()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is OnboardingInProgress) {
            return OnboardingView(pageIndex: state.pageIndex);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
