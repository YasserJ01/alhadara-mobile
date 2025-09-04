import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/features/hall_services/domain/entities/result_hall_booking_entity.dart';
import 'package:alhadara/features/hall_services/domain/entities/search_booking_request_entity.dart';
import 'package:alhadara/features/hall_services/presentation/widgets/hall_card.dart';
import 'package:alhadara/features/hall_services/presentation/widgets/no_results_widget.dart';
import 'package:alhadara/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class HallResultsPage extends StatefulWidget {
  final List<HallBookingEntity> halls;
  final BookingRequestEntity searchRequest; // Add the search request

  const HallResultsPage({super.key, required this.halls,required this.searchRequest});

  @override
  State<HallResultsPage> createState() => _HallResultsPageState();
}

class _HallResultsPageState extends State<HallResultsPage> {
  int? _selectedHallIndex;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Available Halls',
      backIconColor: Colors.white,
      textColor: Colors.white,
      backgroundColor: AppColors.mainColor,
      icon: Icons.home_outlined,
      endIconColor: Colors.white,
      onPressedEndIcon: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return const HomePage();
            },
          ),
        );
      },
      edgeInsets: const EdgeInsets.all(2),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mainColor.withOpacity(0.03),
              AppColors.mainColor.withOpacity(0.01),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header Section
              _buildHeaderSection(),
              const SizedBox(height: 20),

              // Results Count and Filter
              //  _buildResultsInfoSection(),

              // const SizedBox(height: 16),

              // Halls List
              Expanded(
                child: widget.halls.isEmpty
                    ? const NoResultsWidget()
                    : _buildHallsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.mainColor.withOpacity(0.04),
            AppColors.mainColor.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.mainColor.withOpacity(0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.mainColor.withOpacity(0.12),
            ),
            child: Icon(
              Icons.meeting_room,
              size: 28,
              color: AppColors.mainColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Perfect Venues Found!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainColor,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'We found ${widget.halls.length} amazing halls matching your criteria',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildResultsInfoSection() {
  //   return Row(
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //         decoration: BoxDecoration(
  //           color: AppColors.mainColor.withOpacity(0.1),
  //           borderRadius: BorderRadius.circular(12),
  //           border: Border.all(
  //             color: AppColors.mainColor.withOpacity(0.2),
  //           ),
  //         ),
  //         child: Row(
  //           children: [
  //             Icon(
  //               Icons.filter_list_rounded,
  //               size: 16,
  //               color: AppColors.mainColor,
  //             ),
  //             const SizedBox(width: 6),
  //             Text(
  //               '${widget.halls.length} Results',
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w600,
  //                 color: AppColors.mainColor,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const Spacer(),
  //       if (_selectedHallIndex != null)
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //           decoration: BoxDecoration(
  //             color: AppColors.mainColor.withOpacity(0.08),
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: Text(
  //             '1 selected',
  //             style: TextStyle(
  //               fontSize: 11,
  //               color: AppColors.mainColor,
  //               fontWeight: FontWeight.w500,
  //             ),
  //           ),
  //         ),
  //     ],
  //   );
  // }

  Widget _buildHallsList() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: widget.halls.length,
          itemBuilder: (context, index) {
            final hall = widget.halls[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: HallCard(
                hallBooking: hall,
                isSelected: _selectedHallIndex == index,
                onTap: () {
                  setState(() {
                    if (_selectedHallIndex == index) {
                      _selectedHallIndex = null;
                    } else {
                      _selectedHallIndex = index;
                    }
                  });
                },
                bookingDate: widget.searchRequest.date,
                bookingStartTime: widget.searchRequest.startTime,
                bookingEndTime: widget.searchRequest.endTime,
                bookingType: widget.searchRequest.bookingType,
                headcount: widget.searchRequest.numberOfAttendees,
              ),
            );
          },
        ),
      ),
    );
  }
}
