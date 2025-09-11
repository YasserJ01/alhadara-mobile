import '../../domain/entities/result_hall_booking_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../bloc/hall_booking_bloc.dart';
import '../bloc/hall_booking_state.dart';
import 'service_chip.dart';

class ServicesSection extends StatelessWidget {
  final Set<int> selectedServices;
  final Function(int serviceId, bool selected) onServiceSelected;

  const ServicesSection({
    super.key,
    required this.selectedServices,
    required this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.mainColor.withOpacity(0.2),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.room_service_outlined,
                color: AppColors.mainColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Available Services',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          BlocBuilder<HallBookingBloc, HallBookingState>(
            builder: (context, state) {
              if (state is ServicesLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ServicesError) {
                return Text(
                  'Error: ${state.message}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                );
              } else if (state is ServicesLoaded) {
                return _buildServicesList(state.services);
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServicesList(List<ServiceEntity> services) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: services.map((service) => ServiceChip(
        service: service,
        isSelected: selectedServices.contains(service.id),
        onSelected: (selected) => onServiceSelected(service.id, selected),
      )).toList(),
    );
  }
}