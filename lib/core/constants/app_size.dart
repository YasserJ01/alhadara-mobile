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
}
