import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'dependencies.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/spalsh_screen/presentation/pages/splash_screen.dart';
import 'features/start/presentation/pages/start_page.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins', // Applies to all Text widgets
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          // Customize other text styles as needed
        ),
      ),
      initialRoute: '/splashScreen',
      routes: {
        '/splashScreen' : (context) => const SplashScreen(),
        '/start': (context) => const StartPage(),
        '/login': (context) => const LoginPage(), // Your existing login page
        '/guest': (context) => Container(), // Create this if needed
      },
    );
  }
}
