import 'package:flutter/material.dart';

class StartLogo extends StatelessWidget {

  const StartLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo.png',  // Replace with your logo path
      height: MediaQuery.of(context).size.height/5,
    );
  }
}