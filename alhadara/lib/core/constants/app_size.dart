import 'package:flutter/material.dart';

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
