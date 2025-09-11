import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/presentation/bloc/theme_bloc.dart';
import '../../theme/presentation/bloc/theme_state.dart';
import '../theme/app_theme_helper.dart';
import 'app_size.dart';

class AppElevatedButton extends StatelessWidget {
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
  final bool useThemeColor;

  const AppElevatedButton({
    Key? key,
    this.child,
    this.side,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.icon,
    this.label,
    this.useThemeColor = true, // Default to using theme color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        // Default colors
        Color defaultBackgroundColor = const Color.fromRGBO(162, 12, 13, 1.0);
        Color defaultTextColor = Colors.white;

        // Use theme colors if enabled and theme is loaded
        if (useThemeColor && themeState is ThemeLoaded) {
          defaultBackgroundColor = AppThemeHelper.getIconColor(themeState.theme);
          defaultTextColor = AppThemeHelper.getTextColor(themeState.theme);
        }

        // Use provided colors or fall back to theme/default colors
        final Color effectiveBackgroundColor = backgroundColor ?? defaultTextColor;
        final Color effectiveTextColor = textColor ?? defaultTextColor;

        return SizedBox(
          width: width ?? double.infinity,
          height: height ??
              AppSizes.responsiveSize(context, mobile: 56, tablet: 64, desktop: 72),
          child: isLoading
              ? ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              side: side,
              backgroundColor: effectiveBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
            ),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
              ),
            ),
          )
              : icon != null
              ? ElevatedButton.icon(
            onPressed: onPressed,
            icon: icon!,
            label: DefaultTextStyle.merge(
              style: TextStyle(color: effectiveTextColor),
              child: label!,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: effectiveBackgroundColor,
              foregroundColor: effectiveTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
            ),
          )
              : ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: side,
              backgroundColor: effectiveBackgroundColor,
              foregroundColor: effectiveTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
            ),
            onPressed: onPressed,
            child: DefaultTextStyle.merge(
              style: TextStyle(color: effectiveTextColor),
              child: child ?? const SizedBox(),
            ),
          ),
        );
      },
    );
  }
}