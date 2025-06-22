import 'package:flutter/material.dart';
import 'app_size.dart';

class AppElevatedButton extends StatelessWidget {
  //final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final BorderSide? side;
  final Widget? icon;
  final Widget? label;

  const AppElevatedButton(
      {Key? key,
      this.child,
      //this.text,
      this.side,
      this.onPressed,
      this.isLoading = false,
      this.width,
      this.height,
      this.backgroundColor,
      this.textColor,
      this.borderRadius,
      this.icon,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ??
          AppSizes.responsiveSize(context, mobile: 56, tablet: 64, desktop: 72),
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              icon: icon!,
              label: label!,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    backgroundColor ?? const Color.fromRGBO(162, 12, 13, 1.0),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 5),
                ),
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: side,
                backgroundColor:
                    backgroundColor ?? const Color.fromRGBO(162, 12, 13, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 5),
                ),
              ),
              onPressed: onPressed,
              child: child,
            ),
    );
  }
}
