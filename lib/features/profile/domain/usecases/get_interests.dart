// import 'package:alhadara/features/interests/domain/entities/interest.dart';
// import 'package:alhadara/features/interests/domain/repositories/interest_repository.dart';

// class GetInterests {
//   final InterestRepository repository;

//   GetInterests(this.repository);

//   Future<List<Interest>> call() async {
//     return await repository.getInterests();
//   }
// }


import 'package:project2/features/profile/domain/repositories/profile_repository.dart';

import '../entity/interests.dart';

class GetInterestsUseCase {
  final ProfileRepository repository;

  GetInterestsUseCase({required this.repository});

  Future<List<InterestEntity>> call() async {
    return await repository.getInterests();
  }
}