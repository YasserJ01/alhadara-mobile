import 'package:alhadara/features/hall_services/domain/entities/result_hall_booking_entity.dart';
import 'package:flutter/material.dart';
import 'package:alhadara/core/constants/colors.dart';

class ServiceChip extends StatelessWidget {
  final ServiceEntity service;
  final bool isSelected;
  final Function(bool) onSelected;

  const ServiceChip({
    super.key,
    required this.service,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        '${service.name} - \$${service.price.toStringAsFixed(2)}',
        style: TextStyle(
          fontSize: 12,
          color: isSelected ? Colors.white : AppColors.mainColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: Colors.white,
      selectedColor: AppColors.mainColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.mainColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      elevation: 1,
      labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}