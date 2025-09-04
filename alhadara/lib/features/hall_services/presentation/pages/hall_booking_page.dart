import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/hall_services/domain/entities/result_hall_booking_entity.dart';
import 'package:alhadara/features/hall_services/presentation/bloc/hall_booking_bloc.dart';
import 'package:alhadara/features/hall_services/presentation/bloc/hall_booking_event.dart';
import 'package:alhadara/features/hall_services/presentation/bloc/hall_booking_state.dart';
import 'package:alhadara/features/hall_services/presentation/widgets/booking_form.dart';
import 'package:alhadara/features/hall_services/presentation/widgets/hall_card.dart';
import 'package:alhadara/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HallBookingPage extends StatelessWidget {
  const HallBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Hall Booking',
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
      body: BlocProvider(
        create: (context) => getIt<HallBookingBloc>(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header Section
                      _buildHeaderSection(),
                      const SizedBox(height: 20),

                      // Booking Form Section
                      _buildFormSection(),

                      const SizedBox(height: 2),

                      // Results Section
                      //   _buildResultsSection(context),
                    ],
                  ),
                ),
              ),
            );
          },
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
          Icon(
            Icons.event_available_rounded,
            size: 32,
            color: AppColors.mainColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find Your Perfect Hall',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainColor,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Search and book the ideal hall for your event with our advanced booking system',
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

  Widget _buildFormSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: AppColors.mainColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BookingForm(),
      ),
    );
  }

 }

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
            Icons.search_rounded,
            'Find Your Perfect Hall',
            'Enter your event details above to discover available halls that match your requirements',
          );
        } else if (state is HallBookingLoading) {
          return _buildLoading();
        } else if (state is HallBookingError) {
          return _buildError(state.message);
        }
        // else if (state is HallBookingLoaded) {
        //   return _buildHallsList(state.halls);
        // }
        return const SizedBox();
      },
    );
  }

  Widget _buildPlaceholder(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mainColor.withOpacity(0.1),
              ),
              child: Icon(
                icon,
                size: 48,
                color: AppColors.mainColor.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.mainColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
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
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.mainColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Searching for perfect halls...',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We\'re finding the best options for your event',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
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
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withOpacity(0.1),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<HallBookingBloc>().add(LoadServicesEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }


}
