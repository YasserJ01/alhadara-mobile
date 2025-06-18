import 'package:flutter/material.dart';
import 'package:project2/core/widgets/language_switcher.dart';
import '../widgets/start_logo.dart';
import '../widgets/start_buttons.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(162, 12, 13, 1.0),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StartLogo(), // Company logo
            // SizedBox(height: 40),
            Column(
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400,color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  'Enjoy the world\'s fastest and best education',
                  style: TextStyle(fontSize: 15.2, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            // SizedBox(height: 40),
            StartButtons(), // Sign in + Guest buttons
            // LanguageSwitcher(),
          ],
        ),
      ),
    );
  }
}
