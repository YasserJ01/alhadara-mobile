// presentation/widgets/course_details_card.dart
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependencies.dart';
import '../../../enrollment/presentation/bloc/enrolling/enroll_bloc.dart';
import '../../../enrollment/presentation/bloc/enrolling/enroll_event.dart';
import '../../../enrollment/presentation/bloc/enrolling/enroll_state.dart';
import '../../../enrollment/presentation/bloc/enrollments/enrollment_bloc.dart';
import '../../../enrollment/presentation/pages/enrollment_page.dart';
import '../../../wishlist/presentation/bloc/wishlist_bloc.dart';
import '../../../wishlist/presentation/bloc/wishlist_event.dart';
import '../../../wishlist/presentation/bloc/wishlist_state.dart';
import 'wishlistButton.dart';

// presentation/widgets/course_details_card.dart
class CourseDetailsCard extends StatelessWidget {
  final int courseId;
  final String courseTitle;
  final String courseDesc;
  final String coursePrice;
  final int courseDuration;
  final int maxStudent;
  final bool certificationEligible;
  final int? selectedScheduleId; // Add this parameter
  final bool isWishlisted;

  const CourseDetailsCard({
    Key? key,
    required this.courseId,
    required this.courseTitle,
    required this.courseDesc,
    required this.coursePrice,
    required this.courseDuration,
    required this.maxStudent,
    required this.certificationEligible,
    this.selectedScheduleId,
    required this.isWishlisted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Course title with buttons
        Row(
          children: [
            Expanded(
              child: Text(
                courseTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Wishlist button
            // BlocConsumer<WishlistBloc, WishlistState>(
            //   listener: (context, state) {
            //     if (state is WishlistToggleSuccess) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(
            //           content: Text('Wishlist updated successfully'),
            //           backgroundColor: Colors.green,
            //         ),
            //       );
            //     } else if (state is WishlistToggleError) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(
            //           content: Text('Failed to update wishlist'),
            //           backgroundColor: Colors.red,
            //         ),
            //       );
            //     }
            //   },
            //   builder: (context, state) {
            //     return IconButton(
            //         onPressed: state is WishlistLoading
            //             ? null
            //             : () {
            //                 context.read<WishlistBloc>().add(
            //                       ToggleWishlistEvent(courseId),
            //                     );
            //               },
            //         icon: state is WishlistLoading
            //             ? const SizedBox(
            //                 width: 24,
            //                 height: 24,
            //                 child: CircularProgressIndicator(
            //                   strokeWidth: 2,
            //                 ),
            //               )
            //             : isWishlisted == true
            //                 ? const Icon(
            //                     Icons.favorite,
            //                     color: Colors.red,
            //                     size: 28,
            //                   )
            //                 : const Icon(
            //                     Icons.favorite_border,
            //                     color: Colors.red,
            //                     size: 28,
            //                   ));
            //   },
            // ),
            WishlistButton(
              courseId: courseId,
              initialIsWishlisted: isWishlisted,
            ),
            // Enroll button
            BlocConsumer<EnrollBloc, EnrollState>(
              listener: (context, state) {
                if (state is EnrollSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Successfully enrolled in course!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  // Moved the success dialog here
                  AwesomeDialog(
                    context: context,
                    transitionAnimationDuration: const Duration(milliseconds: 500),
                    dialogType: DialogType.success,
                    animType: AnimType.bottomSlide,
                    headerAnimationLoop: false,
                    title: 'SUCCESS',
                    desc: 'Successfully enrolled.. View Enrollments ?',
                    btnCancelOnPress: () => Navigator.pop(context),
                    btnOkOnPress: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => getIt<EnrollmentBloc>()
                                ..add(FetchEnrollments()),
                            ),
                          ],
                          child: const EnrollmentsPage(),
                        ),
                      ),
                    ),
                    buttonsBorderRadius: BorderRadius.circular(0),
                    btnOkColor: Colors.green,
                    btnCancelColor: Colors.red,
                    buttonsTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ).show();
                } else if (state is EnrollError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: (state is EnrollLoading || selectedScheduleId == null)
                      ? null
                      : () {
                    context.read<EnrollBloc>().add(
                      EnrollInCourseEvent(
                        courseId: courseId,
                        scheduleSlotId: selectedScheduleId!,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(162, 12, 13, 1.0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: state is EnrollLoading
                      ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text(
                    'Enroll',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
            // BlocConsumer<EnrollBloc, EnrollState>(
            //   listener: (context, state) {
            //     if (state is EnrollSuccess) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(
            //           content: Text('Successfully enrolled in course!'),
            //           backgroundColor: Colors.green,
            //         ),
            //       );
            //     } else if (state is EnrollError) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text(state.message),
            //           backgroundColor: Colors.red,
            //         ),
            //       );
            //     }
            //   },
            //   builder: (context, state) {
            //     return ElevatedButton(
            //       onPressed: (state is EnrollLoading ||
            //               selectedScheduleId == null)
            //           ? null
            //           : () {
            //               context.read<EnrollBloc>().add(
            //                     EnrollInCourseEvent(
            //                       courseId: courseId,
            //                       scheduleSlotId: selectedScheduleId!,
            //                     ),
            //                   );
            //               AwesomeDialog(
            //                 context: context,
            //                 transitionAnimationDuration:
            //                     const Duration(milliseconds: 500),
            //                 // autoHide: const Duration(seconds: 6),
            //                 dialogType: DialogType.success,
            //                 animType: AnimType.bottomSlide,
            //                 headerAnimationLoop: false,
            //                 title: 'SUCCESS',
            //                 desc: 'Successfully enrolled.. View Enrollments ?',
            //                 // desc: state.error,
            //                 btnCancelOnPress: () => Navigator.pop(context),
            //                 btnOkOnPress: () => Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                     builder: (context) => MultiBlocProvider(
            //                       providers: [
            //                         BlocProvider(
            //                           create: (context) =>
            //                               getIt<EnrollmentBloc>()
            //                                 ..add(FetchEnrollments()),
            //                         ),
            //                       ],
            //                       child: const EnrollmentsPage(),
            //                     ),
            //                   ),
            //                 ),
            //                 buttonsBorderRadius: BorderRadius.circular(0),
            //                 // btnOkIcon: Icons.cancel,
            //                 btnOkColor: Colors.green,
            //                 btnCancelColor: Colors.red,
            //                 buttonsTextStyle: const TextStyle(
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.w700,
            //                   fontSize: 18,
            //                 ),
            //               ).show();
            //             },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.blue,
            //         foregroundColor: Colors.white,
            //         padding:
            //             const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //       ),
            //       child: state is EnrollmentLoading
            //           ? const SizedBox(
            //               width: 16,
            //               height: 16,
            //               child: CircularProgressIndicator(
            //                 strokeWidth: 2,
            //                 color: Colors.white,
            //               ),
            //             )
            //           : const Text(
            //               'Enroll',
            //               style: TextStyle(fontWeight: FontWeight.w600),
            //             ),
            //     );
            //   },
            // ),
          ],
        ),

        const SizedBox(height: 20),

        // Course info grid
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // Hours card
            _buildInfoCard(
              title: 'Hours',
              value: '${courseDuration.toString()} h',
            ),

            // Price card
            _buildInfoCard(
              title: 'Price',
              value: '\$$coursePrice',
            ),

            // Max Students card
            _buildInfoCard(
              title: 'Max Student',
              value: maxStudent.toString(),
            ),

            // Certificate card
            _buildInfoCard(
              title: 'Certificate',
              child: certificationEligible == true
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
            ),
          ],
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    String? value,
    Widget? child,
  }) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: child ??
                  Text(
                    value ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
