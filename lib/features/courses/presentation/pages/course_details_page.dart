// features/courses/presentation/pages/course_details_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/dependencies.dart'; // Import your dependency injection
import '../../../../core/constants/app_back_button.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/constants/colors.dart';
import '../../../enrollment/presentation/bloc/enrolling/enroll_bloc.dart';
import '../bloc/course_schedule_bloc/course_schedule_bloc.dart';
import '../bloc/course_schedule_bloc/course_schedule_event.dart';
import '../bloc/course_schedule_bloc/course_schedule_state.dart';
import '../widgets/course_details_bottom_sheet.dart';
import '../widgets/course_details_card.dart';
import '../widgets/course_schedule_list.dart';
import '../../../wishlist/presentation/bloc/wishlist_bloc.dart'; // Import WishlistBloc
// features/courses/presentation/pages/course_details_page.dart

class CourseDetailsPage extends StatelessWidget {
  final int courseId;
  final String courseTitle;
  final String courseDesc;
  final String coursePrice;
  final int courseDuration;
  final int maxStudent;
  final bool certificationEligible;
  final bool isWishlisted;

  const CourseDetailsPage({
    Key? key,
    required this.courseId,
    required this.courseTitle,
    required this.courseDesc,
    required this.coursePrice,
    required this.courseDuration,
    required this.maxStudent,
    required this.certificationEligible,
    required this.isWishlisted
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CourseScheduleBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<WishlistBloc>(),
        ),*/
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<CourseScheduleBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<WishlistBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt<EnrollBloc>(),
          ),
      ],
      child:  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: AppSizes.screenHeight(context) * 0.09,
          backgroundColor: Colors.white,
          shadowColor: const Color.fromARGB(157, 244, 248, 251),
          leading: Padding(
            padding: EdgeInsets.only(left: AppSizes.screenWidth(context) * 0.03),
            child: const AppBackButton(),
          ),
          title: const Text(
            'Details',
            style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding:
              EdgeInsets.only(right: AppSizes.screenWidth(context) * 0.03),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: AppColors.mainColor,
                      size: AppSizes.screenWidth(context) * 0.09,
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: AppSizes.screenWidth(context) * 0,
                    top: AppSizes.screenHeight(context) * 0.01,
                    child: Container(
                      padding:
                      EdgeInsets.all(AppSizes.screenWidth(context) * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: AppSizes.screenWidth(context) * 0.055,
                        minHeight: AppSizes.screenHeight(context) * 0,
                      ),
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.screenWidth(context) * 0.03,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              bottom: 250,
              child: Image.asset(
                'assets/course.jpg',
                fit: BoxFit.contain,
              ),
            ),
            CourseDetailsBottomSheet(
              courseId: courseId,
              courseTitle: courseTitle,
              courseDesc: courseDesc,
              coursePrice: coursePrice,
              courseDuration: courseDuration,
              maxStudent: maxStudent,
              certificationEligible: certificationEligible,
              isWishlisted: isWishlisted,
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/course_schedule_bloc/course_schedule_bloc.dart';
// import '../bloc/course_schedule_bloc/course_schedule_event.dart';
// import '../bloc/course_schedule_bloc/course_schedule_state.dart';
// import '../widgets/course_details_bottom_sheet.dart';
// import '../widgets/course_details_card.dart';
// import '../widgets/course_schedule_list.dart';
//
// class CourseDetailsPage extends StatelessWidget {
//
//   final int courseId;
//   final String courseTitle;
//   final String courseDesc;
//   final String coursePrice;
//   final int courseDuration;
//   final int maxStudent;
//   final bool certificationEligible;
//
//   const CourseDetailsPage({
//     Key? key,
//     required this.courseId,
//     required this.courseTitle,
//     required this.courseDesc,
//     required this.coursePrice,
//     required this.courseDuration,
//     required this.maxStudent,
//     required this.certificationEligible,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text('Front-End'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Badge(
//               label: Text('2'),
//               child: Icon(Icons.notifications_outlined),
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(
//             child: Image.asset(
//               'assets/img_1.png',
//               fit: BoxFit.fill,
//             ),
//           ),
//           CourseDetailsBottomSheet(
//             courseId: courseId,
//             courseTitle: courseTitle,
//             courseDesc: courseDesc,
//             coursePrice: coursePrice,
//             courseDuration: courseDuration,
//             maxStudent: maxStudent,
//             certificationEligible: certificationEligible,
//           ),
//         ],
//       ),
//     );
//   }
// }
