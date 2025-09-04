import 'package:alhadara/core/constants/colors.dart';
import 'package:flutter/material.dart';

class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.mainColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No halls available for your search criteria',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.mainColor.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}