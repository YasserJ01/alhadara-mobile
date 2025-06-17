// features/profile/data/models/create_profile_response_model.dart
class CreateProfileResponseModel {
  final int id;

  CreateProfileResponseModel({required this.id});

  factory CreateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateProfileResponseModel(
      id: json['id'] as int,
    );
  }
}