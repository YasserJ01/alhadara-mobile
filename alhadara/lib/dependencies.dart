// dependencies.dart

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:alhadara/features/courses/data/datasources/courses_remote_data_source.dart';
import 'package:alhadara/features/courses/data/repositories/department_repository_impl.dart';
import 'package:alhadara/features/courses/domain/repositories/courses_repository.dart';
import 'package:alhadara/features/courses/domain/usecases/get_departments.dart';
import 'package:alhadara/features/courses/presentation/bloc/course_types_bloc/course_types_bloc.dart';
import 'package:alhadara/features/courses/presentation/bloc/department_bloc/departments_bloc.dart';
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
import 'package:alhadara/features/reset_password/data/datasources/reset_password_datasource.dart';
import 'package:alhadara/features/reset_password/data/repositories/reset_password_repository_im.dart';
import 'package:alhadara/features/reset_password/domain/repositories/reset_passwor_repository.dart';
import 'package:alhadara/features/reset_password/domain/usecases/request_question.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/answar_security_question/answar_security_qu_bloc.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/new_password/new_password_bloc.dart';
import 'package:alhadara/features/reset_password/presentation/bloc/reset_password/reset_password_bloc.dart';

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
  getIt.registerFactory(
      () => AuthBloc(loginWithPhoneUseCase: getIt<LoginWithPhoneUseCase>()));

  getIt.registerSingleton<RegisterUseCase>(
    RegisterUseCase(getIt<AuthRepository>()),
  );
  getIt.registerFactory(
      () => RegisterBloc(registerUseCase: getIt<RegisterUseCase>()));

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

  // Data Layer
  getIt.registerLazySingleton<PasswordResetApi>(
    () => PasswordResetApi(client: getIt()),
  );
  getIt.registerLazySingleton<PasswordResetRepository>(
    () => PasswordResetRepositoryImpl(api: getIt()),
  );

  // Domain Layer
  getIt.registerLazySingleton<RequestSecurityQuestionUseCase>(
    () => RequestSecurityQuestionUseCase(getIt()),
  );
  getIt.registerLazySingleton<ValidateSecurityAnswerUseCase>(
    () => ValidateSecurityAnswerUseCase(getIt()),
  );
  getIt.registerLazySingleton<ConfirmPasswordResetUseCase>(
    () => ConfirmPasswordResetUseCase(getIt()),
  );

  // Presentation Layer
  getIt.registerFactory<RequestSecurityQuestionBloc>(
    () => RequestSecurityQuestionBloc(
      requestSecurityQuestionUseCase: getIt(),
    ),
  );
  getIt.registerFactory<AnswerSecurityQuestionBloc>(
    () => AnswerSecurityQuestionBloc(
      validateSecurityAnswerUseCase: getIt(),
    ),
  );
  getIt.registerFactory<ResetPasswordBloc>(
    () => ResetPasswordBloc(
      confirmPasswordResetUseCase: getIt(),
    ),
  );

  // Departments Feature
  // Data sources
  getIt.registerLazySingleton<CoursesRemoteDataSource>(
    () => CoursesRemoteDataSourceImpl(client: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<CoursesRepository>(
    () => DepartmentRepositoryImpl(
      remoteDataSource: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetDepartments(getIt()));

  // Bloc
  getIt.registerFactory(
    () => DepartmentsBloc(getDepartments: getIt()),
  );
  // Course Types Feature

  // Use cases
  getIt.registerLazySingleton(() => GetCourseTypes(getIt()));

  // Bloc
  getIt.registerFactory(
    () => CourseTypesBloc(getCourseTypes: getIt()),
  );
}
