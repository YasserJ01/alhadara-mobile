import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_scaffold.dart';
import '../../../../dependencies.dart';
import '../../domain/usecases/delete_private_lesson_request.dart';
import '../../domain/usecases/get_private_lesson_requests.dart';
import '../../domain/usecases/pick_proposed_option.dart';
import '../bloc/get_private_lesson/private_lesson_requests_list_bloc.dart';
import '../widgets/get-private-lesson.dart';

class PrivateLessonRequestsListPage extends StatelessWidget {
  const PrivateLessonRequestsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrivateLessonRequestsListBloc(
        getPrivateLessonRequests: getIt<GetPrivateLessonRequests>(),
        pickProposedOption: getIt<PickProposedOption>(),
        deletePrivateLessonRequest: getIt<DeletePrivateLessonRequest>(),
      )..add(LoadPrivateLessonRequests()),
      child: const AppScaffold(
        body: PrivateLessonRequestsListView(),
        title: 'Private Lesson',
      ),
    );
  }
}


