// features/courses/domain/repositories/enrollment_repository.dart
import 'dart:io';

import '../../data/models/bulletin_post_model.dart';
import '../entities/enrollment.dart';
import '../entities/enrollment_entity.dart';
import '../entities/homework.dart';
import '../entities/lesson.dart';
import '../entities/news_feed_entity.dart';

abstract class EnrollmentRepository {
  Future<EnrollEntity> enrollInCourse({
    required int courseId,
    required int scheduleSlotId,
    required String notes,
  });
  Future<List<EnrollmentEntity>> getEnrollments();
  Future<void> processPayment(int enrollmentId, double amount);
  Future<List<Lesson>> getLessons(int scheduleSlotId);
  Future<List<Homework>> getHomeworkByLessonId(int lessonId);
  Future<List<NewsFeedEntity>> getNewsFeed(int scheduleSlotId);
  Future<Map<String, dynamic>> createLesson({
    required String title,
    String? notes,
    File? file,
    String? link,
    required int courseId,
    required int scheduleSlotId,
    required String lessonDate,
    required String status,
  });

  Future<void> createHomework({
    required String title,
    required String description,
    required String formLink,
    required DateTime deadline,
    required int lessonId,
    required int maxScore,
    required bool isMandatory,
  });

  Future<void> createBulkAttendance({
    required List<Map<String, dynamic>> records,
  });

  Future<void> publishPost(BulletinPostModel post);

}