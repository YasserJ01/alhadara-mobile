import 'package:flutter/material.dart';
import 'package:alhadara/core/constants/colors.dart';

class BookingTypeDropdown extends StatelessWidget {
  final String bookingType;
  final ValueChanged<String?> onChanged;

  const BookingTypeDropdown({
    super.key,
    required this.bookingType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> bookingTypes = ['public', 'private'];

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
      child: DropdownButtonFormField<String>(
        value: bookingType,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Booking Type',
          labelStyle: TextStyle(
            color: AppColors.mainColor.withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        items: bookingTypes.map((String type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text(
              type[0].toUpperCase() + type.substring(1),
              style: const TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select booking type';
          }
          return null;
        },
      ),
    );
  }
}