import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/privet_lesson/domain/usecases/create_private_lesson_request.dart';
import 'package:alhadara/features/privet_lesson/presentation/bloc/private_lesson_request_bloc.dart';
import 'package:alhadara/features/privet_lesson/presentation/widgets/private_lesson_request_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivateLessonRequestPage extends StatelessWidget {
  final int scheduleSlotId;

  const PrivateLessonRequestPage({
    super.key,
    required this.scheduleSlotId,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: 'Private lesson',
        body: BlocProvider(
          create: (context) => PrivateLessonRequestBloc(
            createPrivateLessonRequest: getIt<CreatePrivateLessonRequest>(),
          ),
          child: SingleChildScrollView(
            child: PrivateLessonRequestForm(scheduleSlotId: 281),
          ),
        ));
    //  Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Request Private Lesson'),
    //     elevation: 0,
    //   ),
    //   body:
    // BlocProvider(
    //     create: (context) => PrivateLessonRequestBloc(
    //       createPrivateLessonRequest: getIt<CreatePrivateLessonRequest>(),
    //     ),
    //     child: SingleChildScrollView(
    //       child: PrivateLessonRequestForm(scheduleSlotId: 281),
    //     ),
    //   ),
    // );
  }
}
