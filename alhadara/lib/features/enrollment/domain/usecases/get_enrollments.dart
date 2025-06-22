import '../entities/enrollment_entity.dart';
import '../repositories/enrollment_repository.dart';

class GetEnrollments {
  final EnrollmentRepository repository;

  GetEnrollments(this.repository);

  Future<List<EnrollmentEntity>> call() async {
    return await repository.getEnrollments();
  }
}
