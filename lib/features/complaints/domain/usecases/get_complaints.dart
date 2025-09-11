import '../../data/models/complaint_model.dart';

import '../repositories/complaint_repository.dart';

class GetComplaints {
  final ComplaintRepository repository;

  GetComplaints(this.repository);

  Future<List<ComplaintModel>> call() async {
    return await repository.getComplaints();
  }
}