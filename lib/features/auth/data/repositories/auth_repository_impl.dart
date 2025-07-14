// auth/data/repositories/auth_repository_impl.dart
import '../../../../core/services/token_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

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

  // @override
  // Future<UserEntity> loginWithPhone(String phone, String password) async {
  //   final request = LoginRequestModel(
  //     phone: phone,
  //     password: password,
  //   );
  //   final response = await remoteDataSource.loginWithPhone(request);
  //   print(response['access']);
  //
  //   return UserEntity(
  //     phone: phone,
  //     accessToken: response['access'],
  //     refreshToken: response['refresh'],
  //   );
  // }

  @override
  Future<String> register(
    String firstName,
    String middleName,
    String lastName,
    String phone,
    String password,
    String confirm_password,
  ) async {
    final request = RegisterRequestModel(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      phone: phone,
      password: password,
      confirm_password: confirm_password,
    );
    final response = await remoteDataSource.register(request);
    return response['access'] as String;
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
    await TokenService.clearTokens();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await TokenService.isLoggedIn();
  }
}
