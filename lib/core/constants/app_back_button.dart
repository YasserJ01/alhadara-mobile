
import 'package:flutter/material.dart';

import 'app_size.dart';
import 'colors.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;

  const AppBackButton({Key? key, this.onPressed, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back,
        size: AppSizes.responsiveSize(context,
            mobile: 40, tablet: 44, desktop: 48),
        color: color ?? AppColors.mainColor,
      ),
      padding: EdgeInsets.all(
          AppSizes.responsiveSize(context, mobile: 8, tablet: 12, desktop: 16)),
    );
  }
}
