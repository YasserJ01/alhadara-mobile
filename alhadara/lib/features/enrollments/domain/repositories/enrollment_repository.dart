import 'package:alhadara/features/enrollments/domain/entities/enrollment_entity.dart';

abstract class EnrollmentRepository {
  Future<List<EnrollmentEntity>> getEnrollments();
  Future<void> processPayment(int enrollmentId, double amount);
}