import '../../data/models/complaint_model.dart';

import '../entities/complaint_entity.dart';
import '../repositories/complaint_repository.dart';

class SubmitComplaintUseCase {
  final ComplaintRepository repository;

  SubmitComplaintUseCase(this.repository);

  Future<ComplaintModel> call(Complaint complaint) async {
    return await repository.submitComplaint(complaint);
  }
}