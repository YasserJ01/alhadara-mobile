import 'package:alhadara/core/constants/app_size.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AppBackButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back,
        size: AppSizes.responsiveSize(context,
            mobile: 40, tablet: 44, desktop: 48),
        color: AppColors.mainColor,
      ),
      padding: EdgeInsets.all(
          AppSizes.responsiveSize(context, mobile: 8, tablet: 12, desktop: 16)),
    );
  }
}
