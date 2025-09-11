import '../entities/feedback_entity.dart';
import '../../data/models/feedback_model.dart';

abstract class FeedbackRepository {
  Future<FeedbackModel> submitFeedback(FeedbackEntity feedback);
}