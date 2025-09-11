
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_scaffold.dart';
import '../../../../dependencies.dart';
import '../../domain/usecases/create_private_lesson_request.dart';
import '../bloc/private_lesson_request/private_lesson_request_bloc.dart';
import '../widgets/private_lesson_request_form.dart';

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
          child:  SingleChildScrollView(
            child: PrivateLessonRequestForm(scheduleSlotId: scheduleSlotId),
          ),
        ));
  }
}
