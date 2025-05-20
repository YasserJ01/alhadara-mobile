import 'package:alhadara/core/constants/app_back_button.dart';
import 'package:alhadara/core/constants/app_size.dart';
import 'package:flutter/material.dart';

class ResetPasswordScaffold extends StatelessWidget {
  final Widget body;
  final VoidCallback? onBackPressed;

  const ResetPasswordScaffold({
    Key? key,
    required this.body,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
            onPressed: onBackPressed ?? () => Navigator.pop(context)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.responsiveSize(context,
                mobile: 16, tablet: 24, desktop: 32),
          ),
          child: body,
        ),
      ),
    );
  }
}
