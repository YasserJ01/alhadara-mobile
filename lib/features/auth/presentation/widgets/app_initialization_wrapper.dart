// lib/core/app/app_initialization_wrapper.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/features/home/presentation/pages/home_page.dart';

import '../bloc/auth_bloc.dart';
import '../pages/login_page.dart';

class AppInitializationWrapper extends StatefulWidget {
  const AppInitializationWrapper({super.key});

  @override
  State<AppInitializationWrapper> createState() => _AppInitializationWrapperState();
}

class _AppInitializationWrapperState extends State<AppInitializationWrapper> {
  @override
  void initState() {
    super.initState();
    // Check auth status when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(CheckAuthStatusRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // Show loading screen while checking auth status
        if (state is AuthInitial) {
          return const AppLoadingScreen();
        }

        // User is authenticated and should stay signed in
        if (state is AuthAuthenticated) {
          return const HomePage(); // or your home page
        }

        // User needs to login (show login page with saved credentials if available)
        return const LoginPage();
      },
    );
  }
}

class AppLoadingScreen extends StatelessWidget {
  const AppLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(162, 12, 13, 1.0),
              Color.fromRGBO(162, 12, 13, 0.8),
            ],
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your app logo here if you have one
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
            ),
            SizedBox(height: 24),
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}