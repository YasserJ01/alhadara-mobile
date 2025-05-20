// import 'package:flutter/material.dart';

// class StartLogo extends StatelessWidget {
//   const StartLogo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       'assets/logo.png', // Replace with your logo path
//       height: MediaQuery.of(context).size.height / 5,
//     );
//   }
// }
import 'package:alhadara/core/constants/app_size.dart';
import 'package:flutter/material.dart';

class StartLogo extends StatelessWidget {
  const StartLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo.png',
      height: AppSizes.screenHeight(context) * 0.2, // 20% of screen height
      width: AppSizes.screenWidth(context) * 0.6, // 60% of screen width
      fit: BoxFit.contain,
    );
  }
}
