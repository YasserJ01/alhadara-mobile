import 'package:alhadara/features/enrollments/domain/repositories/enrollment_repository.dart';

class ProcessPayment {
  final EnrollmentRepository repository;

  ProcessPayment(this.repository);

  Future<void> call(int enrollmentId, double amount) async {
    return await repository.processPayment(enrollmentId, amount);
  }
}