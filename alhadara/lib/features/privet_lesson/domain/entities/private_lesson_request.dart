// import 'package:alhadara/features/privet_lesson/data/models/private_lesson_request_model.dart';

// class PrivateLessonRequest {
//   final int id;
//   final int student;
//   final int scheduleSlot;
//   final String preferredDate;
//   final String preferredTimeFrom;
//   final String preferredTimeTo;
//   final String status;
//   final String? confirmedDate;
//   final String? confirmedTimeFrom;
//   final String? confirmedTimeTo;
//   final String createdAt;
//   final String updatedAt;
//   final List<dynamic> proposedOptions;

//   PrivateLessonRequest({
//     required this.id,
//     required this.student,
//     required this.scheduleSlot,
//     required this.preferredDate,
//     required this.preferredTimeFrom,
//     required this.preferredTimeTo,
//     required this.status,
//     this.confirmedDate,
//     this.confirmedTimeFrom,
//     this.confirmedTimeTo,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.proposedOptions,
//   });
// }

// extension PrivateLessonRequestModelExtension on PrivateLessonRequestModel {
//   PrivateLessonRequest toEntity() {
//     return PrivateLessonRequest(
//       id: id,
//       student: student,
//       scheduleSlot: scheduleSlot,
//       preferredDate: preferredDate,
//       preferredTimeFrom: preferredTimeFrom,
//       preferredTimeTo: preferredTimeTo,
//       status: status,
//       confirmedDate: confirmedDate,
//       confirmedTimeFrom: confirmedTimeFrom,
//       confirmedTimeTo: confirmedTimeTo,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//       proposedOptions: proposedOptions,
//     );
//   }
// }
import 'package:alhadara/features/privet_lesson/data/models/private_lesson_request_model.dart';

class ProposedOption {
  final int id;
  final String date;
  final String timeFrom;
  final String timeTo;
  final String createdAt;

  ProposedOption({
    required this.id,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.createdAt,
  });
}

class PrivateLessonRequest {
  final int id;
  final int student;
  final int scheduleSlot;
  final String preferredDate;
  final String preferredTimeFrom;
  final String preferredTimeTo;
  final String status;
  final String? confirmedDate;
  final String? confirmedTimeFrom;
  final String? confirmedTimeTo;
  final String createdAt;
  final String updatedAt;
  final List<ProposedOption> proposedOptions;

  PrivateLessonRequest({
    required this.id,
    required this.student,
    required this.scheduleSlot,
    required this.preferredDate,
    required this.preferredTimeFrom,
    required this.preferredTimeTo,
    required this.status,
    this.confirmedDate,
    this.confirmedTimeFrom,
    this.confirmedTimeTo,
    required this.createdAt,
    required this.updatedAt,
    required this.proposedOptions,
  });
}

extension PrivateLessonRequestModelExtension on PrivateLessonRequestModel {
  PrivateLessonRequest toEntity() {
    return PrivateLessonRequest(
      id: id,
      student: student,
      scheduleSlot: scheduleSlot,
      preferredDate: preferredDate,
      preferredTimeFrom: preferredTimeFrom,
      preferredTimeTo: preferredTimeTo,
      status: status,
      confirmedDate: confirmedDate,
      confirmedTimeFrom: confirmedTimeFrom,
      confirmedTimeTo: confirmedTimeTo,
      createdAt: createdAt,
      updatedAt: updatedAt,
      proposedOptions: proposedOptions
          .map((option) => ProposedOption(
                id: option.id,
                date: option.date,
                timeFrom: option.timeFrom,
                timeTo: option.timeTo,
                createdAt: option.createdAt,
              ))
          .toList(),
    );
  }
}