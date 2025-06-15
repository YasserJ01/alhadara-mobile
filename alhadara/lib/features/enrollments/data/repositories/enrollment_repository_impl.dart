import 'package:alhadara/errors/expections.dart';
import 'package:alhadara/features/enrollments/data/datasources/enrollment_remote_data_source.dart';
import 'package:alhadara/features/enrollments/domain/entities/enrollment_entity.dart';
import 'package:alhadara/features/enrollments/domain/repositories/enrollment_repository.dart';

class EnrollmentRepositoryImpl implements EnrollmentRepository {
  final EnrollmentRemoteDataSource remoteDataSource;

  EnrollmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<EnrollmentEntity>> getEnrollments() async {
    try {
      final enrollments = await remoteDataSource.getEnrollments();
      return enrollments.map((enrollment) => EnrollmentEntity(
        id: enrollment.id,
        studentName: enrollment.studentName,
        courseTitle: enrollment.courseTitle,
        scheduleSlotDisplay: enrollment.scheduleSlotDisplay,
        status: enrollment.status,
        paymentStatus: enrollment.paymentStatus,
        enrollmentDate: enrollment.enrollmentDate,
        amountPaid: enrollment.amountPaid,
        remainingBalance: enrollment.remainingBalance,
        notes: enrollment.notes,
      )).toList();
    } on ServerException {
      throw ServerException();
    }
  }
    @override
  Future<void> processPayment(int enrollmentId, double amount) async {
    try {
      await remoteDataSource.processPayment(enrollmentId, amount);
    } on ServerException {
      throw ServerException();
    }
  }
}