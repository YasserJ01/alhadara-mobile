import 'package:flutter/material.dart';
import 'app_size.dart';

class AppElevatedButton extends StatelessWidget {
  //final String? text;
  final Widget child;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final BorderSide? side;

  const AppElevatedButton({
    Key? key,
    required this.child,
    //this.text,
    this.side,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ??
          AppSizes.responsiveSize(context, mobile: 56, tablet: 64, desktop: 72),
      child: ElevatedButton(
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
