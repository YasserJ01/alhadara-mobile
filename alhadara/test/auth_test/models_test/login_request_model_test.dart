import 'package:flutter_test/flutter_test.dart';
import 'package:alhadara/features/auth/data/models/login_request_model.dart';
// Import your app files

void main() {
  group('LoginRequestModel', () {
    test('should convert to JSON correctly', () {
      // Arrange
      final model = LoginRequestModel(
        phone: '0991234567',
        password: 'password123',
      );

      final expectedJson = {
        'phone': '0991234567',
        'password': 'password123',
      };

      // Act
      final result = model.toJson();

      // Assert
      expect(result, equals(expectedJson));
    });
  });
}