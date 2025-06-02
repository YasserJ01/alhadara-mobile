// // domain/repositories/interest_repository.dart
// import 'package:alhadara/features/interests/domain/entities/interest.dart';
// import 'package:alhadara/features/interests/domain/usecases/add_multiple_interests.dart';

// abstract class InterestRepository {
//   Future<List<Interest>> getInterests();
//   Future<void> addUserInterest(int profileId, int interestId, int intensity);
  
// }
import 'package:alhadara/features/interests/domain/entities/interest.dart';


abstract class InterestRepository {
  Future<List<InterestEntity>> getInterests();
  Future<void> saveUserInterests(int profileId, int interestId, int intensity);
}