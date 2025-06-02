import 'package:alhadara/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:alhadara/core/constants/app_size.dart';

class NotificationBadge extends StatelessWidget {
  final int count;
  final VoidCallback? onPressed;
  final double? iconSize;
  final Color? iconColor;
  final Color? badgeColor;
  final Color? textColor;

  const NotificationBadge({
    super.key,
    required this.count,
    this.onPressed,
    this.iconSize,
    this.iconColor,
    this.badgeColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            color: iconColor ?? AppColors.mainColor,
            size: iconSize ?? AppSizes.screenWidth(context) * 0.09,
          ),
          onPressed: onPressed,
        ),
        if (count > 0)
          Positioned(
            right: AppSizes.screenWidth(context) * 0,
            top: AppSizes.screenHeight(context) * 0.01,
            child: Container(
              padding: EdgeInsets.all(AppSizes.screenWidth(context) * 0.01),
              decoration: BoxDecoration(
                color: badgeColor ?? Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: AppSizes.screenWidth(context) * 0.055,
                minHeight: AppSizes.screenHeight(context) * 0,
              ),
              child: Text(
                count > 9 ? '9+' : count.toString(),
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: AppSizes.screenWidth(context) * 0.03,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
      ],
    );
  }
}
