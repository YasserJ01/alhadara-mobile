import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/features/hall_services/domain/entities/result_hall_booking_entity.dart';
import 'package:alhadara/features/hall_services/domain/entities/search_booking_request_entity.dart';
import 'package:alhadara/features/hall_services/presentation/bloc/hall_booking_bloc.dart';
import 'package:alhadara/features/hall_services/presentation/bloc/hall_booking_state.dart';
import 'package:alhadara/features/hall_services/presentation/widgets/hall_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HallsList extends StatefulWidget {
  const HallsList({super.key});

  @override
  State<HallsList> createState() => _HallsListState();
}

class _HallsListState extends State<HallsList> {
  int? _selectedHallIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HallBookingBloc, HallBookingState>(
      builder: (context, state) {
        if (state is HallBookingInitial) {
          return _buildPlaceholder(
              'Enter search criteria to find available halls');
        } else if (state is HallBookingLoading) {
          return _buildLoading();
        } else if (state is HallBookingError) {
          return _buildError(state.message);
        } else if (state is HallBookingLoaded) {
          return _buildHallsList(state.halls,state.searchRequest);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildPlaceholder(String text) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_outlined,
              size: 48,
              color: AppColors.mainColor.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.mainColor.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.mainColor,
            ),
            SizedBox(height: 16),
            Text(
              'Searching for available halls...',
              style: TextStyle(
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Error: $message',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHallsList(List<HallBookingEntity> halls, BookingRequestEntity searchRequest) {
    if (halls.isEmpty) {
      return _buildPlaceholder('No halls available for your search criteria');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: halls.length,
      itemBuilder: (context, index) {
        final hall = halls[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: HallCard(
            hallBooking: hall,
            isSelected: _selectedHallIndex == index,
            onTap: () {
              setState(() {
                if (_selectedHallIndex == index) {
                  _selectedHallIndex = null; // Deselect
                } else {
                  _selectedHallIndex = index; // Select
                }
              });
            },
             bookingDate: searchRequest.date,
            bookingStartTime: searchRequest.startTime,
            bookingEndTime: searchRequest.endTime,
            bookingType: searchRequest.bookingType,
            headcount: searchRequest.numberOfAttendees,
          ),
        );
      },
    );
  }
}