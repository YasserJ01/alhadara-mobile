import 'package:alhadara/core/constants/app_back_button.dart';
import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? backIconColor;
  final String title;
  final EdgeInsets? edgeInsets;

  const AppScaffold(
      {Key? key,
      required this.body,
      this.onBackPressed,
      required this.title,
      this.backgroundColor,
      this.textColor,
      this.backIconColor,
      this.edgeInsets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor ?? AppColors.mainColor,
            fontSize: AppSizes.responsiveFontSize(context,
                mobile: 32, tablet: 36, desktop: 40),
          ),
          textAlign: TextAlign.center,
        ),
        leading: AppBackButton(
            color: backIconColor ?? AppColors.mainColor,
            onPressed: onBackPressed ?? () => Navigator.pop(context)),
        backgroundColor: backgroundColor ?? Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding:edgeInsets?? EdgeInsets.symmetric(
            horizontal: AppSizes.responsiveSize(context,
                mobile: 16, tablet: 24, desktop: 32),
          ),
          child: body,
        ),
      ),
    );
  }
}
