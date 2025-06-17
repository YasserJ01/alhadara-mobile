// features/courses/presentation/pages/course_details_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/dependencies.dart'; // Import your dependency injection
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
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Front-End'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Badge(
                label: Text('2'),
                child: Icon(Icons.notifications_outlined),
              ),
              onPressed: () {},
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
