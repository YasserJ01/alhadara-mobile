// core/widgets/no_item_widget.dart
import 'package:flutter/material.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/core/constants/app_size.dart';

class NoItemWidget extends StatelessWidget {
  final String message;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final TextStyle? textStyle;

  const NoItemWidget({
    super.key,
    required this.message,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.search_off,
            size: iconSize ??
                AppSizes.screenWidth(context) * 0.2, // 15% of screen width
            color: iconColor ?? AppColors.mainColor,
          ),
          SizedBox(
              height:
                  AppSizes.screenHeight(context) * 0.02), // 2% of screen height
          Text(
            message,
            textAlign: TextAlign.center,
            style: textStyle ??
                TextStyle(
                  fontSize: AppSizes.screenWidth(context) *
                      0.06, // 4% of screen width
                  color: AppColors.greyColor,
                ),
          ),
        ],
      ),
    );
  }
}
