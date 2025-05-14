// auth/data/models/register_request_model.dart
class RegisterRequestModel {
  final String firstName;
  final String middleName;
  final String lastName;
  final String phone;
  final String password;
  final String confirm_password;

  RegisterRequestModel({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phone,
    required this.password,
    required this.confirm_password,
  });

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'middle_name': middleName,
        'last_name': lastName,
        'phone': phone,
        'password': password,
        'confirm_password': confirm_password,
        'user_type': "student",
      };
}
