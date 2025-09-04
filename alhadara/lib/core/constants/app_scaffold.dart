import 'package:flutter/material.dart';

import 'app_back_button.dart';
import 'app_size.dart';
import 'colors.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? backIconColor;
  final Color? endIconColor;
  final String title;
  final EdgeInsets? edgeInsets;
  final VoidCallback? onPressedEndIcon;
  final IconData? icon;
  final double? elevation;

  const AppScaffold(
      {Key? key,
      required this.body,
      this.onBackPressed,
      required this.title,
      this.backgroundColor,
      this.textColor,
      this.backIconColor,
      this.endIconColor,
      this.edgeInsets,
      this.onPressedEndIcon,
      this.icon,
      this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //  toolbarHeight: AppSizes.screenHeight(context) * 0.09,
          shadowColor: const Color.fromARGB(157, 244, 248, 251),
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
          actions: [
            Padding(
              padding:
                  EdgeInsets.only(right: AppSizes.screenWidth(context) * 0.03),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      icon,
                      // Icons.notifications_outlined,
                      //Icons.home_sharp,Icons.home_sharp,
                      color:endIconColor?? const Color.fromRGBO(162, 12, 13, 1.0),
                      size: AppSizes.screenWidth(context) * 0.09,
                    ),
                    onPressed: onPressedEndIcon,
                  ),
                  icon == Icons.notifications_outlined
                      ? Positioned(
                          right: AppSizes.screenWidth(context) * 0,
                          top: AppSizes.screenHeight(context) * 0.01,
                          child: Container(
                            padding: EdgeInsets.all(
                                AppSizes.screenWidth(context) * 0.01),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: BoxConstraints(
                              minWidth: AppSizes.screenWidth(context) * 0.055,
                              minHeight: AppSizes.screenHeight(context) * 0,
                            ),
                            child: Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppSizes.screenWidth(context) * 0.03,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
          backgroundColor: backgroundColor ?? Colors.white,
          elevation: elevation ?? 0),
      body: SafeArea(
        child: Padding(
          padding: edgeInsets ??
              EdgeInsets.symmetric(
                horizontal: AppSizes.responsiveSize(context,
                    mobile: 16, tablet: 24, desktop: 32),
              ),
          child: body,
        ),
      ),
    );
  }
}
