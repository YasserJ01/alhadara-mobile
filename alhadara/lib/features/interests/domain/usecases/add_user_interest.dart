// // // domain/usecases/add_user_interest.dart
// // import 'package:alhadara/features/interests/domain/repositories/interest_repository.dart';

// // class AddUserInterest {
// //   final InterestRepository repository;

// //   AddUserInterest(this.repository);

// //   Future<void> call({
// //     required int profileId,
// //     required int interestId,
// //     required int intensity,
// //   }) async {
// //     return await repository.addUserInterest(profileId, interestId, intensity);
// //   }
// // }
// // domain/usecases/add_user_interest.dart
// import 'package:alhadara/features/interests/domain/repositories/interest_repository.dart';

// class AddUserInterest {
//   final InterestRepository repository;

//   AddUserInterest(this.repository);

//   Future<void> call({
//     required int profileId,
//     required int interestId,
//     required int intensity,
//   }) async {
//     return await repository.addUserInterest(
//       profileId: profileId,
//       interestId: interestId,
//       intensity: intensity,
//     );
//   }
// }