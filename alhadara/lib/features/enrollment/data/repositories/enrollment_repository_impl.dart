// features/courses/data/repositories/enrollment_repository_impl.dart
import '../../../../errors/expections.dart';
import '../../../../errors/failures.dart';
import '../../domain/entities/enrollment_entity.dart';
import '../datasources/enrollment_remote_data_source.dart';
import '../../domain/entities/enrollment.dart';
import '../../domain/repositories/enrollment_repository.dart';

class EnrollmentRepositoryImpl implements EnrollmentRepository {
  final EnrollmentRemoteDataSource remoteDataSource;

  EnrollmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<EnrollEntity> enrollInCourse({
    required int courseId,
    required int scheduleSlotId,
    required String notes,
  }) async {
    try {
      final enrollment = await remoteDataSource.enrollInCourse(
        courseId: courseId,
        scheduleSlotId: scheduleSlotId,
        notes: notes,
      );
      return enrollment;
    } on ValidationnException catch (e) {
      throw ValidationnException(e.toString());
    } on HttpFailure catch (e) {
      throw HttpFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }
  // @override
  // Future<EnrollEntity> enrollInCourse({
  //   required int courseId,
  //   required int scheduleSlotId,
  //   required String notes,
  // }) async {
  //   try {
  //     final enrollment = await remoteDataSource.enrollInCourse(
  //       courseId: courseId,
  //       scheduleSlotId: scheduleSlotId,
  //       notes: notes,
  //     );
  //     return enrollment;
  //   } catch (e) {
  //     if (e is HttpFailure) {
  //       throw HttpFailure();
  //     } else {
  //       throw ServerFailure();
  //     }
  //   }
  // }

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
    } catch (e) {
      if (e is HttpFailure) {
        throw HttpFailure();
      } else {
        throw ServerFailure();
      }
    }
  }
  @override
  Future<void> processPayment(int enrollmentId, double amount) async {
    try {
      await remoteDataSource.processPayment(enrollmentId, amount);
    } catch (e) {
      if (e is HttpFailure) {
        throw HttpFailure();
      } else {
        throw ServerFailure();
      }
    }
  }
}
