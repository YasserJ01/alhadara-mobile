// // data/repositories/interest_repository_impl.dart
// import 'package:alhadara/errors/expections.dart';
// import 'package:alhadara/errors/failures.dart';
// import 'package:alhadara/features/interests/data/datasources/interest_remote_data_source.dart';
// import 'package:alhadara/features/interests/data/models/interest_model.dart';
// import 'package:alhadara/features/interests/domain/entities/interest.dart';
// import 'package:alhadara/features/interests/domain/repositories/interest_repository.dart';

// class InterestRepositoryImpl implements InterestRepository {
//   final InterestRemoteDataSource remoteDataSource;

//   InterestRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<List<Interest>> getInterests() async {
//     try {
//       final response = await remoteDataSource.getInterests();
//       return response.map((json) => InterestModel.fromJson(json)).toList();
//     } on ServerException {
//       throw ServerFailure();
//     }
//   }

//   @override
//   Future<void> addUserInterest(int profileId, int interestId, int intensity) async {
//     try {
//       await remoteDataSource.addUserInterest(profileId, interestId, intensity);
//     } on ServerException {
//       throw ServerFailure();
//     }
//   }
// }
import 'package:alhadara/features/interests/domain/entities/interest.dart';

import '../../domain/repositories/interest_repository.dart';
import '../datasources/interest_remote_data_source.dart';
import '../models/interest_model.dart';

class InterestRepositoryImpl implements InterestRepository {
  final InterestRemoteDataSource remoteDataSource;

  InterestRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<InterestEntity>> getInterests() async {
    final interests = await remoteDataSource.getInterests();
    return interests.map((interest) => InterestModel.fromJson(interest).toEntity()).toList();
  }

  @override
  Future<void> saveUserInterests(int profileId, int interestId, int intensity) {
    return remoteDataSource.saveUserInterests(profileId, interestId, intensity);
  }
}