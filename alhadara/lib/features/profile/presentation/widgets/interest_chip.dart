import 'package:flutter/material.dart';
import '../../domain/entity/interest.dart';

class InterestChip extends StatelessWidget {
  final Interest interest;

  const InterestChip({Key? key, required this.interest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = _getColorByIntensity(interest.intensity);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            interest.interestName,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 4),
          // Text(
          //   '(${interest.intensity})',
          //   style: TextStyle(
          //     color: color.withOpacity(0.8),
          //     fontSize: 12,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
        ],
      ),
    );
  }

  Color _getColorByIntensity(int intensity) {
    switch (intensity) {
      case 1:
        return Colors.grey;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}