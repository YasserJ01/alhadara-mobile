// presentation/pages/create_lesson_combo_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../dependencies.dart';
import '../../../domain/usecases/create_lesson_combo.dart';
import '../../bloc/lesson_combo/lesson_combo_bloc.dart';
import '../../widgets/teacher/create_lesson_combo_form.dart';

class CreateLessonComboPage extends StatelessWidget {
  const CreateLessonComboPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Lesson')),
      body: BlocProvider(
        create: (context) => LessonComboBloc(
          createLessonCombo: getIt<CreateLessonCombo>(),
        ),
        child: const CreateLessonComboForm(),
      ),
    );
  }
}