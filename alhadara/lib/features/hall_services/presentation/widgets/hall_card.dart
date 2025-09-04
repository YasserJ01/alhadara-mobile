import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/features/hall_services/domain/entities/result_hall_booking_entity.dart';
import 'package:alhadara/features/hall_services/domain/entities/hall_booking.dart';
import 'package:alhadara/features/hall_services/presentation/bloc/hall_booking_bloc.dart';
import 'package:alhadara/features/hall_services/presentation/bloc/hall_booking_event.dart';
import 'package:alhadara/features/hall_services/presentation/bloc/hall_booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HallCard extends StatefulWidget {
  final HallBookingEntity hallBooking;
  final bool isSelected;
  final VoidCallback onTap;
  
  // Add booking parameters that were used in the search
  final DateTime bookingDate;
  final String bookingStartTime;
  final String bookingEndTime;
  final String bookingType;
  final int headcount;

  const HallCard({
    super.key,
    required this.hallBooking,
    required this.isSelected,
    required this.onTap,
    required this.bookingDate,
    required this.bookingStartTime,
    required this.bookingEndTime,
    required this.bookingType,
    required this.headcount,
  });

  @override
  State<HallCard> createState() => _HallCardState();
}

class _HallCardState extends State<HallCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HallBookingBloc, HallBookingState>(
      
      listener: (context, state) {
        if (state is BookingCreated) {
          _showSuccessDialog(context, state.booking);
        } else if (state is BookingCreationError) {
          _showErrorDialog(context, state.message);
        }
      },
      child: GestureDetector(
        onTap: () {
          widget.onTap();
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: widget.isSelected
                  ? AppColors.mainColor.withOpacity(0.8)
                  : Color.fromARGB(255, 148, 36, 36).withOpacity(0.5),
              width: widget.isSelected ? 2 : 1,
            ),
          ),
          shadowColor: AppColors.mainColor.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hall name and remaining seats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.hallBooking.hall.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.mainColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${widget.hallBooking.remainingSeats} left',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Location and capacity
                _buildInfoRow(
                  Icons.location_on_outlined,
                  widget.hallBooking.hall.location,
                ),
                const SizedBox(height: 4),
                _buildInfoRow(
                  Icons.people_outline,
                  'Capacity: ${widget.hallBooking.hall.capacity} people',
                ),
                const SizedBox(height: 12),

                // Price section
                _buildPriceSection(),
                const SizedBox(height: 12),

                // Services section (if any)
                if (widget.hallBooking.includedServices.isNotEmpty) ...[
                  _buildServicesSection(),
                  const SizedBox(height: 12),
                ],

                // Book button (only shown when selected and expanded)
                if (widget.isSelected && _isExpanded) ...[
                  BlocBuilder<HallBookingBloc, HallBookingState>(
                    builder: (context, state) {
                      bool isBooking = state is BookingCreating;
                      
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isBooking ? null : () => _bookHall(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainColor,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: AppColors.mainColor.withOpacity(0.6),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: isBooking
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Booking...',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(
                                  'Book Now',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],

                // Selection indicator
                if (widget.isSelected && !_isExpanded)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.check_circle,
                      color: AppColors.mainColor,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.mainColor.withOpacity(0.6),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.mainColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          if (widget.hallBooking.servicesPrice > 0) ...[
            _buildPriceRow('Services', widget.hallBooking.servicesPrice),
            const SizedBox(height: 4),
          ],
          const Divider(height: 8),
          _buildPriceRow(
            'Total',
            widget.hallBooking.totalPrice,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double price, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? AppColors.mainColor : Colors.grey[700],
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStyle(
            color: isTotal ? AppColors.mainColor : Colors.black,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            fontSize: isTotal ? 16 : 12,
          ),
        ),
      ],
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Included Services:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.mainColor,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: widget.hallBooking.includedServices
              .map((service) => Chip(
                    label: Text(
                      '${service.name}',
                      style: const TextStyle(fontSize: 10),
                    ),
                    backgroundColor: AppColors.mainColor.withOpacity(0.1),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ))
              .toList(),
        ),
      ],
    );
  }

  void _bookHall(BuildContext context) {
    final booking = BookingCreateEntity(
      hall: widget.hallBooking.hall.id,
      date: widget.bookingDate,
      startTime: widget.bookingStartTime,
      endTime: widget.bookingEndTime,
      bookingType: widget.bookingType,
      headcount: widget.headcount,
    );

    context.read<HallBookingBloc>().add(CreateBookingEvent(booking: booking));
  }

  void _showSuccessDialog(BuildContext context, BookingResponseEntity booking) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Booking Confirmed!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your hall has been successfully booked!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              _buildBookingDetail('Booking ID', '#${booking.id}'),
              _buildBookingDetail('Hall', booking.hallName),
              _buildBookingDetail('Date', booking.date),
              _buildBookingDetail('Time', '${booking.startTime} - ${booking.endTime}'),
              _buildBookingDetail('Attendees', '${booking.headcount} people'),
              _buildBookingDetail('Total Price', '\$${booking.calculatedPrice.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Optionally navigate to bookings history or home
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'OK',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Booking Failed',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'We couldn\'t complete your booking.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  errorMessage,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red[700],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Try Again',
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text(
                'Close',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBookingDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}