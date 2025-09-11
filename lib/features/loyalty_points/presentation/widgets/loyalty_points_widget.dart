// widgets/loyalty_points_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/core/constants/colors.dart';
import '../bloc/loyalty_points_bloc.dart';
import '../bloc/loyalty_points_event.dart';
import '../bloc/loyalty_points_state.dart';

class LoyaltyPointsWidget extends StatelessWidget {
  const LoyaltyPointsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoyaltyPointsBloc, LoyaltyPointsState>(
      builder: (context, state) {
        if (state is LoyaltyPointsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoyaltyPointsLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<LoyaltyPointsBloc>().add(RefreshLoyaltyPointsEvent());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.mainColor,AppColors.mainColor.withOpacity(0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.stars,
                          size: 48,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Your Loyalty Points',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${state.loyaltyPoints.points}',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Points',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (state.loyaltyPoints.hasLoyaltyPoints) ...[
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildDetailRow('Points ID', '${state.loyaltyPoints.id}'),
                            _buildDetailRow('Student ID', '${state.loyaltyPoints.student}'),
                            if (state.loyaltyPoints.updatedAt != null)
                              _buildDetailRow(
                                'Last Updated',
                                '${state.loyaltyPoints.updatedAt!.day}/${state.loyaltyPoints.updatedAt!.month}/${state.loyaltyPoints.updatedAt!.year}',
                              ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 48,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No loyalty points found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Start earning points by making purchases and engaging with our services!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<LoyaltyPointsBloc>().add(RefreshLoyaltyPointsEvent());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh Points'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is LoyaltyPointsError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<LoyaltyPointsBloc>().add(GetLoyaltyPointsEvent());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(
          child: Text('Welcome! Tap refresh to load your loyalty points.'),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}