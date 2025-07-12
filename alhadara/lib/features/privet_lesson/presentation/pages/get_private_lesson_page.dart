import 'package:alhadara/core/constants/app_scaffold.dart';
import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/dependencies.dart';
import 'package:alhadara/features/privet_lesson/domain/entities/private_lesson_request.dart';
import 'package:alhadara/features/privet_lesson/domain/usecases/delete_private_lesson_request.dart';
import 'package:alhadara/features/privet_lesson/domain/usecases/get_private_lesson_requests.dart';
import 'package:alhadara/features/privet_lesson/domain/usecases/pick_proposed_option.dart';
import 'package:alhadara/features/privet_lesson/presentation/bloc/get_private_lesson.dart/private_lesson_requests_list_bloc.dart';
import 'package:alhadara/features/privet_lesson/presentation/widgets/get-private-lesson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
      child: AppScaffold(
        body: const PrivateLessonRequestsListView(),
        title: 'Private Lesson',
      ),
    );
  }
}


