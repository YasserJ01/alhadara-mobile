import 'package:alhadara/features/enrollments/domain/entities/enrollment_entity.dart';
import 'package:alhadara/features/enrollments/domain/repositories/enrollment_repository.dart';

class GetEnrollments {
  final EnrollmentRepository repository;

  GetEnrollments(this.repository);

  Future<List<EnrollmentEntity>> call() async {
    return await repository.getEnrollments();
  }
}