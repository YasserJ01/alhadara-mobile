import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/enrollment_entity.dart';
import '../bloc/enrollments/enrollment_bloc.dart';
import 'enrollment_card.dart';

class EnrollmentsView extends StatelessWidget {
  const EnrollmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnrollmentBloc, EnrollmentState>(
      builder: (context, state) {
        if (state is EnrollmentInitial || state is EnrollmentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EnrollmentError) {
          return Center(child: Text(state.message));
        } else if (state is EnrollmentLoaded) {
          return _buildEnrollmentsList(state.enrollments);
        }
        // إضافة return افتراضي لتجنب التحذير
        return const SizedBox.shrink(); // أو أي widget افتراضي آخر
      },
    );
  }

  Widget _buildEnrollmentsList(List<EnrollmentEntity> enrollments) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: enrollments.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ExpandableEnrollmentCard(enrollment: enrollments[index]),
        );
      },
    );
  }
}