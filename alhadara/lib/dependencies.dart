import 'package:alhadara/features/courses/domain/usecases/get_courses.dart';
import 'package:alhadara/features/courses/presentation/bloc/courses_bloc/courses_bloc.dart';
import 'package:alhadara/features/home/presentation/bloc/home_bloc.dart';
import 'package:alhadara/features/interests/data/datasources/interest_remote_data_source.dart';
import 'package:alhadara/features/interests/data/repositories/interest_repository_impl.dart';
import 'package:alhadara/features/interests/domain/entities/interest.dart';
import 'package:alhadara/features/interests/domain/repositories/interest_repository.dart';
import 'package:alhadara/features/interests/domain/usecases/get_interests.dart';
import 'package:alhadara/features/interests/domain/usecases/save_user_interests_usecase.dart';
import 'package:alhadara/features/interests/presentation/interestSelection/bloc/interest_selection_bloc.dart';
import 'package:alhadara/features/interests/presentation/interest_rating/bloc/interest_rating_bloc.dart';
import 'package:alhadara/features/payment/depositmethod/data/datasources/deposit_method_remote_data_source.dart';
import 'package:alhadara/features/payment/depositmethod/data/repositories/deposit_method_repository_impl.dart';
import 'package:alhadara/features/payment/depositmethod/domain/repositories/deposit_method_repository.dart';
import 'package:alhadara/features/payment/depositmethod/domain/usecases/get_deposit_methods.dart';
import 'package:alhadara/features/payment/depositmethod/presentation/bloc/deposit/deposit_bloc.dart';
import 'package:alhadara/features/wallet/data/datasourses/wallet_remote_data_source.dart';
import 'package:alhadara/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:alhadara/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:alhadara/features/wallet/domain/usecases/get_transactions.dart';
import 'package:alhadara/features/wallet/domain/usecases/get_wallet.dart';
import 'package:alhadara/features/wallet/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:alhadara/features/wallet/presentation/bloc/wallet_bloc.dart';
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
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
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

  // Reset Password Feature
  getIt.registerLazySingleton<PasswordResetApi>(
    () => PasswordResetApi(client: getIt()),
  );
  getIt.registerLazySingleton<PasswordResetRepository>(
    () => PasswordResetRepositoryImpl(api: getIt()),
  );

  getIt.registerLazySingleton<RequestSecurityQuestionUseCase>(
    () => RequestSecurityQuestionUseCase(getIt()),
  );
  getIt.registerLazySingleton<ValidateSecurityAnswerUseCase>(
    () => ValidateSecurityAnswerUseCase(getIt()),
  );
  getIt.registerLazySingleton<ConfirmPasswordResetUseCase>(
    () => ConfirmPasswordResetUseCase(getIt()),
  );

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

  // Courses Feature
  getIt.registerLazySingleton<CoursesRemoteDataSource>(
    () => CoursesRemoteDataSourceImpl(client: getIt()),
  );

  getIt.registerLazySingleton<CoursesRepository>(
    () => DepartmentRepositoryImpl(
      remoteDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => GetDepartments(getIt()));
  getIt.registerFactory(() => DepartmentsBloc(getDepartments: getIt()));

  getIt.registerLazySingleton(() => GetCourseTypes(getIt()));
  getIt.registerFactory(() => CourseTypesBloc(getCourseTypes: getIt()));

  getIt.registerFactory(() => CoursesBloc(getCourses: getIt()));
  getIt.registerLazySingleton(() => GetCourses(getIt()));

  getIt.registerFactory(() => HomeBloc());


//interest
// Data sources
getIt.registerLazySingleton<InterestRemoteDataSource>(
  () => InterestRemoteDataSourceImpl(client: getIt()),
);

// Repositories
getIt.registerLazySingleton<InterestRepository>(
  () => InterestRepositoryImpl(remoteDataSource: getIt()),
);

// Use cases
getIt.registerLazySingleton(() => GetInterestsUseCase(repository: getIt()));
getIt.registerLazySingleton(() => SaveUserInterestsUseCase(repository: getIt()));

// Blocs
getIt.registerFactory(() => InterestSelectionBloc(getInterestsUseCase: getIt()));
getIt.registerFactoryParam<InterestRatingBloc, List<InterestEntity>, void>(
  (interests, _) => InterestRatingBloc(
    saveUserInterestsUseCase: getIt(),
    interests: interests,
  ),
);

  // Data sources
  getIt.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(client: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetWallet(getIt()));

  // Bloc
  getIt.registerFactory(
    () => WalletBloc(getWallet: getIt()),
  );
  getIt.registerFactory(() => TransactionBloc(getTransactions: getIt()));
  getIt.registerLazySingleton(() => GetTransactions(getIt()));
// // Register BLoCs
// getIt.registerFactory(() => PaymentMethodSelectionBloc(getDepositMethods: getIt()));
// getIt.registerFactory(() => BankSelectionBloc());
// getIt.registerFactory(() => TransferSelectionBloc());

// // Register use cases
// getIt.registerLazySingleton(() => GetDepositMethods(getIt()));

// // Register repositories
// getIt.registerLazySingleton<PaymentRepository>(
//   () => PaymentRepositoryImpl(remoteDataSource: getIt()),
// );

// // Register data sources
// getIt.registerLazySingleton<PaymentRemoteDataSource>(
//   () => PaymentRemoteDataSourceImpl(client: getIt()),
// );
// Blocs
  getIt.registerFactory(
    () => DepositBloc(getDepositMethods: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetDepositMethods(getIt()));

  // Repository
  getIt.registerLazySingleton<DepositMethodRepository>(
    () => DepositMethodRepositoryImpl(remoteDataSource: getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<DepositMethodRemoteDataSource>(
    () => DepositMethodRemoteDataSourceImpl(client: getIt()),
  );
}
