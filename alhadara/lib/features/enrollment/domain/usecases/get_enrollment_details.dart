import '../entities/enrollment_entity.dart';
import '../repositories/enrollment_repository.dart';

class GetEnrollmentDetails {
  final EnrollmentRepository repository;

  GetEnrollmentDetails(this.repository);

  Future<EnrollmentEntity> call(int enrollmentId) async {
    return await repository.getEnrollmentDetails(enrollmentId);
  }
}