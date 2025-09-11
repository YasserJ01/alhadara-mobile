// features/courses/data/repositories/enrollment_repository_impl.dart
import 'dart:io';

import '../../../../errors/expections.dart';
import '../../../../errors/failures.dart';
import '../../domain/entities/enrollment_entity.dart';
import '../../domain/entities/homework.dart';
import '../../domain/entities/lesson.dart';
import '../../domain/entities/lesson_summary.dart';
import '../../domain/entities/news_feed_entity.dart';
import '../../domain/entities/private_lesson_request.dart';
import '../datasources/enrollment_remote_data_source.dart';
import '../../domain/entities/enrollment.dart';
import '../../domain/repositories/enrollment_repository.dart';
import '../models/bulletin_post_model.dart';
import '../models/homework_model.dart';
import '../models/lesson_model.dart';

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
      return enrollments.map((enrollment) =>
          EnrollmentEntity(
            id: enrollment.id,
            studentName: enrollment.studentName,
            courseTitle: enrollment.courseTitle,
            scheduleSlot: enrollment.scheduleSlot,
            // scheduleSlotDisplay: enrollment.scheduleSlotDisplay,
            status: enrollment.status,
            paymentStatus: enrollment.paymentStatus,
            // paymentMethod: enrollment.paymentMethod,
            // paymentMethodDisplay: enrollment.paymentMethodDisplay,
            enrollmentDate: enrollment.enrollmentDate,
            amountPaid: enrollment.amountPaid,
            remainingBalance: enrollment.remainingBalance,
            // isGuest: enrollment.isGuest,
            courseProgress: enrollment.courseProgress,
            lessonsCount: enrollment.lessonsCount,
            attendance: enrollment.attendance,
            startDate: enrollment.startDate,
            endDate: enrollment.endDate,
            student: enrollment.student
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
  Future<EnrollmentEntity> getEnrollmentDetails(int enrollmentId) async {
    try {
      final enrollment = await remoteDataSource.getEnrollmentDetails(
          enrollmentId);
      return EnrollmentEntity(
        id: enrollment.id,
        studentName: enrollment.studentName,
        courseTitle: enrollment.courseTitle,
        // scheduleSlotDisplay: enrollment.scheduleSlotDisplay,
        scheduleSlot: enrollment.scheduleSlot,
        status: enrollment.status,
        paymentStatus: enrollment.paymentStatus,
        // paymentMethod: enrollment.paymentMethod,
        // paymentMethodDisplay: enrollment.paymentMethodDisplay,
        enrollmentDate: enrollment.enrollmentDate,
        amountPaid: enrollment.amountPaid,
        remainingBalance: enrollment.remainingBalance,
        // isGuest: enrollment.isGuest,
        courseProgress: enrollment.courseProgress,
        lessonsCount: enrollment.lessonsCount,
        attendance: enrollment.attendance,
        startDate: enrollment.startDate,
        endDate: enrollment.endDate,
        student: enrollment.student
      );
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

  @override
  Future<List<LessonSummary>> getLessonSummaries(int scheduleSlotId) async {
    try {
      return await remoteDataSource.getLessonSummaries(scheduleSlotId);
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<List<Lesson>> getLessons(int scheduleSlotId) async {
    try {
      final lessonModels = await remoteDataSource.getLessons(scheduleSlotId);
      return lessonModels.map((model) => _mapToEntity(model)).toList();
    } on ServerException {
      throw ServerFailure();
    } on NotFoundException {
      throw NotFoundFailure('Lessons not found');
    } on UnauthorizedException {
      throw HttpFailure();
    } on ValidationnException {
      throw DataFormatFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }

  Lesson _mapToEntity(LessonModel model) {
    return Lesson(
      id: model.id,
      title: model.title,
      notes: model.notes,
      course: model.course,
      scheduleSlot: model.scheduleSlot,
      lessonOrder: model.lessonOrder,
      lessonDate: model.lessonDate,
      status: model.status,
      hasHomework: model.hasHomework,
    );
  }

  @override
  Future<List<Homework>> getHomeworkByLessonId(int lessonId) async {
    try {
      final homeworkModels =
      await remoteDataSource.getHomeworkByLessonId(lessonId);
      return homeworkModels
          .map((model) => _homeworkMapToEntity(model))
          .toList();
    } on ServerException {
      throw ServerFailure();
    } on ApiException {
      throw HttpFailure();
    } on NotFoundException catch (e) {
      throw NotFoundFailure(e.message);
    } on UnauthorizedException {
      throw HttpFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }

  Homework _homeworkMapToEntity(HomeworkModel model) {
    return Homework(
      id: model.id,
      title: model.title,
      description: model.description,
      deadline: model.deadline,
      maxScore: model.maxScore,
      isMandatory: model.isMandatory,
      status: model.status,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  // features/courses/data/repositories/enrollment_repository_impl.dart

  @override
  Future<List<NewsFeedEntity>> getNewsFeed(int scheduleSlotId) async {
    try {
      final models = await remoteDataSource.getNewsFeed(scheduleSlotId);
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> createLesson({
    required String title,
    String? notes,
    File? file,
    String? link,
    required int courseId,
    required int scheduleSlotId,
    required String lessonDate,
    required String status,
  }) async {
    try {
      return await remoteDataSource.createLesson(
        title: title,
        notes: notes,
        file: file,
        link: link,
        courseId: courseId,
        scheduleSlotId: scheduleSlotId,
        lessonDate: lessonDate,
        status: status,
      );
    } on ApiException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<void> createHomework({
    required String title,
    required String description,
    required String formLink,
    required DateTime deadline,
    required int lessonId,
    required int maxScore,
    required bool isMandatory,
  }) async {
    try {
      await remoteDataSource.createHomework(
        title: title,
        description: description,
        formLink: formLink,
        deadline: deadline,
        lessonId: lessonId,
        maxScore: maxScore,
        isMandatory: isMandatory,
      );
    } on ApiException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<void> createBulkAttendance({
    required List<Map<String, dynamic>> records,
  }) async {
    try {
      await remoteDataSource.createBulkAttendance(records: records);
    } on ApiException catch (e) {
      throw ServerException(e.message);
    }
  }


  @override
  Future<void> publishPost(BulletinPostModel post) async {
    try {
      await remoteDataSource.publishPost(post);
    } on ServerException {
      throw ServerFailure();
    } on UnauthorizedException {
      throw UnauthorizedFailure();
    } on ValidationException {
      throw ValidationFailure();
    } on NotFoundException catch (e) {
      throw NotFoundFailure(e.message);
    } on ApiException {
      throw HttpFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<PrivateLessonRequest> createPrivateLessonRequest({
    required int scheduleSlot,
    required String preferredDate,
    required String preferredTimeFrom,
    required String preferredTimeTo,
  }) async {
    final model = await remoteDataSource.createPrivateLessonRequest(
      scheduleSlot: scheduleSlot,
      preferredDate: preferredDate,
      preferredTimeFrom: preferredTimeFrom,
      preferredTimeTo: preferredTimeTo,
    );
    return model.toEntity();
  }

  @override
  Future<List<PrivateLessonRequest>> getPrivateLessonRequests() async {
    final models = await remoteDataSource.getPrivateLessonRequests();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<PrivateLessonRequest> pickProposedOption({
    required int requestId,
    required int optionId,
  }) async {
    final model = await remoteDataSource.pickProposedOption(
      requestId: requestId,
      optionId: optionId,
    );
    return model.toEntity();
  }

  @override
  Future<void> deletePrivateLessonRequest(int requestId) async {
    await remoteDataSource.deletePrivateLessonRequest(requestId);
  }

}
