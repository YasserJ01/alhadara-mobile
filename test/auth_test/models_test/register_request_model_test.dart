import 'package:flutter_test/flutter_test.dart';
import 'package:project2/features/auth/data/models/register_request_model.dart';

void main() {
  group('RegisterRequestModel', () {
    final tRegisterRequestModel = RegisterRequestModel(
      firstName: 'John',
      middleName: 'Middle',
      lastName: 'Doe',
      phone: '1234567890',
      password: 'password123',
      confirm_password: 'password123',
    );

    test('should create instance with correct properties', () {
      // assert
      expect(tRegisterRequestModel.firstName, 'John');
      expect(tRegisterRequestModel.middleName, 'Middle');
      expect(tRegisterRequestModel.lastName, 'Doe');
      expect(tRegisterRequestModel.phone, '1234567890');
      expect(tRegisterRequestModel.password, 'password123');
      expect(tRegisterRequestModel.confirm_password, 'password123');
    });

    test('should return proper json map from toJson', () {
      // act
      final result = tRegisterRequestModel.toJson();

      // assert
      final expectedMap = {
        'first_name': 'John',
        'middle_name': 'Middle',
        'last_name': 'Doe',
        'phone': '1234567890',
        'password': 'password123',
        'confirm_password': 'password123',
        'user_type': 'student',
      };
      expect(result, expectedMap);
    });
  });
}