// // data/models/interest_model.dart
// import 'package:alhadara/features/interests/domain/entities/interest.dart';

// class InterestModel {
//   final int id;
//   final String name;
//   final String category;

//   InterestModel({
//     required this.id,
//     required this.name,
//     required this.category,
//   });

//   factory InterestModel.fromJson(Map<String, dynamic> json) {
//     return InterestModel(
//       id: json['id'],
//       name: json['name'],
//       category: json['category'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'category': category,
//     };
//   }

//   // Add this method to convert model to entity
//   Interest toEntity() {
//     return Interest(
//       id: id,
//       name: name,
//       category: category,
//     );
//   }
// }
// class AddUserInterestParams {
//   final int profileId;
//   final int interestId;
//   final int intensity;

//   AddUserInterestParams({
//     required this.profileId,
//     required this.interestId,
//     required this.intensity,
//   });
// }
import 'package:alhadara/features/interests/domain/entities/interest.dart';

class InterestModel {
  final int id;
  final String name;
  final String category;

  InterestModel({
    required this.id,
    required this.name,
    required this.category,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
    };
  }
  InterestEntity toEntity() {
  return InterestEntity(
    id: id,
    name: name,
    category: category,
  );
}
}
