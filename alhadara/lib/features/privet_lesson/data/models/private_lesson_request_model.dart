// class PrivateLessonRequestModel {
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

//   PrivateLessonRequestModel({
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

//   factory PrivateLessonRequestModel.fromJson(Map<String, dynamic> json) {
//     return PrivateLessonRequestModel(
//       id: json['id'],
//       student: json['student'],
//       scheduleSlot: json['schedule_slot'],
//       preferredDate: json['preferred_date'],
//       preferredTimeFrom: json['preferred_time_from'],
//       preferredTimeTo: json['preferred_time_to'],
//       status: json['status'],
//       confirmedDate: json['confirmed_date'],
//       confirmedTimeFrom: json['confirmed_time_from'],
//       confirmedTimeTo: json['confirmed_time_to'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       proposedOptions: json['proposed_options'] ?? [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'schedule_slot': scheduleSlot,
//       'preferred_date': preferredDate,
//       'preferred_time_from': preferredTimeFrom,
//       'preferred_time_to': preferredTimeTo,
//     };
//   }
// }
class ProposedOptionModel {
  final int id;
  final String date;
  final String timeFrom;
  final String timeTo;
  final String createdAt;

  ProposedOptionModel({
    required this.id,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.createdAt,
  });

  factory ProposedOptionModel.fromJson(Map<String, dynamic> json) {
    return ProposedOptionModel(
      id: json['id'] as int? ?? 0,
      date: json['date'] as String? ?? '',
      timeFrom: json['time_from'] as String? ?? '',
      timeTo: json['time_to'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
    );
  }
}

class PrivateLessonRequestModel {
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
  final List<ProposedOptionModel> proposedOptions;

  PrivateLessonRequestModel({
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

  factory PrivateLessonRequestModel.fromJson(Map<String, dynamic> json) {
    return PrivateLessonRequestModel(
      id: json['id'] as int? ?? 0,
      student: json['student'] as int? ?? 0,
      scheduleSlot: json['schedule_slot'] as int? ?? 0,
      preferredDate: json['preferred_date'] as String? ?? '',
      preferredTimeFrom: json['preferred_time_from'] as String? ?? '',
      preferredTimeTo: json['preferred_time_to'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      confirmedDate: json['confirmed_date'] as String?,
      confirmedTimeFrom: json['confirmed_time_from'] as String?,
      confirmedTimeTo: json['confirmed_time_to'] as String?,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      proposedOptions: (json['proposed_options'] as List<dynamic>? ?? [])
          .map((option) => ProposedOptionModel.fromJson(option))
          .toList(),
    );
  }
}