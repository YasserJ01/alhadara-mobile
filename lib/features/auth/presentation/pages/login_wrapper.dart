// App wrapper to handle authentication state on app start
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../dependencies.dart';
import '../../../onboarding/bloc/onboarding_bloc.dart';
import '../../../onboarding/bloc/onboarding_events.dart';
import '../../../onboarding/screens/onboarding_screen.dart';
import '../bloc/auth_bloc.dart';
import 'login_page.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(CheckAuthStatusRequested()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(162, 12, 13, 1.0),
                ),
              ),
            );
          } else if (state is AuthSuccess || state is AuthAuthenticated) {
            // User is logged in, navigate to main app
            return BlocProvider(
              create: (context) => OnboardingBloc(
                prefs: getIt<SharedPreferences>(),
              )..add(CheckOnboardingStatusEvent()),
              child: const OnboardingScreen(),
            );
          } else {
            // User is not logged in, show login screen
            return const LoginPage();
          }
        },
      ),
    );
  }
}