import 'package:flutter/material.dart';
import 'package:alhadara/core/constants/colors.dart';

class StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final bool isReadOnly;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  const StyledTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.isReadOnly = false,
    this.validator,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.mainColor.withOpacity(0.3),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        readOnly: isReadOnly,
        keyboardType: keyboardType,
        onTap: onTap,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(
            color: AppColors.mainColor.withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          floatingLabelStyle: TextStyle(
            color: AppColors.mainColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        validator: validator,
      ),
    );
  }
}