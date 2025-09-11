// auth/data/repositories/auth_repository_impl.dart
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/token_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/verification_entities.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/verification_remote_datasource.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';
import '../models/verification_models.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final VerificationRemoteDataSource verificationDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.verificationDataSource);

  @override
  Future<UserEntity> loginWithPhone(String phone, String password) async {
    final request = LoginRequestModel(
      phone: phone,
      password: password,
    );

    final tokenResponse = await remoteDataSource.loginWithPhone(request);

    return UserEntity(
      phone: phone,
      accessToken: tokenResponse.access,
      refreshToken: tokenResponse.refresh,
    );
  }


  @override
  Future<String> register(
    String firstName,
    String middleName,
    String lastName,
    String phone,
    String password,
    String confirm_password,
    String captchaKey,
    String captchaAnswer,
  ) async {
    final request = RegisterRequestModel(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      phone: phone,
      password: password,
      confirm_password: confirm_password,
      captchaKey: captchaKey,
      captchaAnswer: captchaAnswer,
    );
    final response = await remoteDataSource.register(request);
    return response['access'] as String;
  }

  @override
  Future<bool> verifyCaptcha(String key, String answer) async {
    return await remoteDataSource.verifyCaptcha(key, answer);
  }

  @override
  Future<void> refreshToken() async {
    final refreshToken = await TokenService.getRefreshToken();
    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }
    await remoteDataSource.refreshToken(refreshToken);
  }

  @override
  Future<void> logout() async {
    // Clear tokens from secure storage
    await TokenService.clearTokens();

    // Optional: Call logout endpoint to invalidate tokens server-side
    // This depends on your API implementation
    try {
      // await remoteDataSource.logout();
    } catch (e) {
      // Log error but don't throw - local logout should still work
      print('Error during server logout: $e');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await TokenService.hasValidSession();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final accessToken = await TokenService.getAccessToken();
    final refreshToken = await TokenService.getRefreshToken();

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    // In a real app, you might want to decode the token to get user info
    // or fetch user data from the server
    final lastPhone = await SecureStorageService.getLastLoginPhone();

    return UserEntity(
      phone: lastPhone ?? '',
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  Future<VerificationResult> startVerification(String phone) async {
    final request = StartVerificationRequest(phone: phone);
    final response = await verificationDataSource.startVerification(request);

    return VerificationResult(
      token: response.token,
      deepLink: response.deepLink,
    );
  }

  @override
  Future<void> submitVerification(String token, String pin) async {
    final request = SubmitVerificationRequest(token: token, pin: pin);
    await verificationDataSource.submitVerification(request);
  }
}
