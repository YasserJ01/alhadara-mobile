import '../../domain/entities/complaint_entity.dart';
import '../../domain/repositories/complaint_repository.dart';
import '../datasources/complaint_remote_datasource.dart';
import '../models/complaint_model.dart';

class ComplaintRepositoryImpl implements ComplaintRepository {
  final ComplaintRemoteDataSource remoteDataSource;

  ComplaintRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ComplaintModel> submitComplaint(Complaint complaint) async {
    return await remoteDataSource.submitComplaint(complaint);
  }
    @override
  Future<List<ComplaintModel>> getComplaints() async {
    return await remoteDataSource.getComplaints();
  }
}