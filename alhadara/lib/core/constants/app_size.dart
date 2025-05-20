// import 'package:flutter/material.dart';

// class AppSizes {
//   static double screenWidth(BuildContext context) =>
//       MediaQuery.of(context).size.width;

//   static double screenHeight(BuildContext context) =>
//       MediaQuery.of(context).size.height;

//   static double paddingTop(BuildContext context) =>
//       MediaQuery.of(context).padding.top;

//   static double paddingBottom(BuildContext context) =>
//       MediaQuery.of(context).padding.bottom;
//        static double paddingRight(BuildContext context) =>
//       MediaQuery.of(context).padding.right;

//   static double paddingLeft(BuildContext context) =>
//       MediaQuery.of(context).padding.left;
// }
import 'package:flutter/material.dart';

// class AppSizes {
//   // Screen dimensions
//   static double screenWidth(BuildContext context) =>
//       MediaQuery.of(context).size.width;

//   static double screenHeight(BuildContext context) =>
//       MediaQuery.of(context).size.height;

//   // Padding
//   static double paddingTop(BuildContext context) =>
//       MediaQuery.of(context).padding.top;

//   static double paddingBottom(BuildContext context) =>
//       MediaQuery.of(context).padding.bottom;

//   static double paddingRight(BuildContext context) =>
//       MediaQuery.of(context).padding.right;

//   static double paddingLeft(BuildContext context) =>
//       MediaQuery.of(context).padding.left;

//   // Responsive size calculations
//   static double responsiveWidth(BuildContext context, double percentage) =>
//       screenWidth(context) * (percentage / 100);

//   static double responsiveHeight(BuildContext context, double percentage) =>
//       screenHeight(context) * (percentage / 100);

//   // Standard padding
//   static EdgeInsets defaultPadding(BuildContext context) =>
//       EdgeInsets.symmetric(
//         horizontal: responsiveWidth(context, 5),
//         vertical: responsiveHeight(context, 2),
//       );

//   // For small components
//   static double smallPadding(BuildContext context) =>
//       responsiveWidth(context, 2);

//   // For medium components
//   static double mediumPadding(BuildContext context) =>
//       responsiveWidth(context, 5);

//   // For large components
//   static double largePadding(BuildContext context) =>
//       responsiveWidth(context, 8);
// }
class AppSizes {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double paddingTop(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double paddingBottom(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;

  static double paddingRight(BuildContext context) =>
      MediaQuery.of(context).padding.right;

  static double paddingLeft(BuildContext context) =>
      MediaQuery.of(context).padding.left;

  // Responsive size calculator
  static double responsiveSize(BuildContext context, 
      {double mobile = 8.0, double tablet = 12.0, double desktop = 16.0}) {
    final width = screenWidth(context);
    if (width < 600) return mobile;
    if (width < 1200) return tablet;
    return desktop;
  }

  // Responsive font size
  static double responsiveFontSize(BuildContext context, 
      {double mobile = 14.0, double tablet = 18.0, double desktop = 22.0}) {
    final width = screenWidth(context);
    if (width < 600) return mobile;
    if (width < 1200) return tablet;
    return desktop;
  }
}