import 'package:alhadara/features/complaints/data/models/complaint_model.dart';

import '../entities/complaint_entity.dart';

abstract class ComplaintRepository {
  Future<ComplaintModel> submitComplaint(Complaint complaint);
    Future<List<ComplaintModel>> getComplaints();

}