  // dependencies.dart

  import 'package:get_it/get_it.dart';
  import 'package:http/http.dart' as http;

  import 'features/auth/data/datasources/auth_remote_data_source.dart';
  import 'features/auth/data/repositories/auth_repository_impl.dart';
  import 'features/auth/domain/repositories/auth_repository.dart';
  import 'features/auth/domain/usecases/login_with_phone_usecase.dart';
  import 'features/auth/domain/usecases/register_usecase.dart';
  import 'features/auth/presentation/bloc/auth_bloc.dart';
  import 'features/auth/presentation/bloc/register/register_bloc.dart';
  import 'features/security_question/data/datasources/security_question_remote_data_source.dart';
  import 'features/security_question/data/repositories/security_question_repository_impl.dart';
  import 'features/security_question/domain/repositories/security_question_repository.dart';
  import 'features/security_question/domain/usecases/get_security_questions_usecase.dart';
import 'features/security_question/domain/usecases/submit_security_answer_usecase.dart';
import 'features/security_question/presentation/bloc/security_question_bloc.dart';

  final getIt = GetIt.instance;

  void setupDependencies() {
    getIt.registerSingleton<http.Client>(http.Client());

    // Auth Feature
    getIt.registerSingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(getIt<http.Client>()),
    );
    getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
    );
    getIt.registerSingleton<LoginWithPhoneUseCase>(
      LoginWithPhoneUseCase(getIt<AuthRepository>()),
    );
    getIt.registerFactory(() => AuthBloc(loginWithPhoneUseCase: getIt<LoginWithPhoneUseCase>()));

    getIt.registerSingleton<RegisterUseCase>(
      RegisterUseCase(getIt<AuthRepository>()),
    );
    getIt.registerFactory(() => RegisterBloc(registerUseCase: getIt<RegisterUseCase>()));

    // Security Question Feature
    getIt.registerFactory<SecurityQuestionRemoteDataSource>(
          () => SecurityQuestionRemoteDataSourceImpl(getIt<http.Client>()),
    );

    getIt.registerFactory<SecurityQuestionRepository>(
          () => SecurityQuestionRepositoryImpl(
        remoteDataSource: getIt<SecurityQuestionRemoteDataSource>(),
      ),
    );

    getIt.registerFactory(
          () => GetSecurityQuestionsUseCase(
        repository: getIt<SecurityQuestionRepository>(),
      ),
    );
    getIt.registerFactory(
          () => SubmitSecurityAnswerUseCase(
        repository: getIt<SecurityQuestionRepository>(),
      ),
    );
    getIt.registerFactory(() => SecurityQuestionBloc(
      getSecurityQuestionsUseCase: getIt<GetSecurityQuestionsUseCase>(),
      submitSecurityAnswerUseCase: getIt<SubmitSecurityAnswerUseCase>(),
    ));
  }