// dependencies.dart

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:project2/features/courses/data/datasources/courses_remote_data_source.dart';
import 'package:project2/features/courses/data/repositories/department_repository_impl.dart';
import 'package:project2/features/courses/domain/repositories/courses_repository.dart';
import 'package:project2/features/courses/domain/usecases/get_departments.dart';
import 'package:project2/features/courses/presentation/bloc/course_types_bloc/course_types_bloc.dart';
import 'package:project2/features/courses/presentation/bloc/courses_bloc/courses_bloc.dart';
import 'package:project2/features/courses/presentation/bloc/department_bloc/departments_bloc.dart';
import 'package:project2/features/payment/presentation/bloc/deposit_request/deposit_request_bloc.dart';
import 'package:project2/features/profile/domain/usecases/get_profile.dart';
import 'package:project2/features/profile/presentation/bloc/view_profile/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_with_phone_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/register/register_bloc.dart';
import 'features/courses/presentation/bloc/course_schedule_bloc/course_schedule_bloc.dart';
import 'features/enrollment/data/datasources/enrollment_remote_data_source.dart';
import 'features/enrollment/data/repositories/enrollment_repository_impl.dart';
import 'features/enrollment/domain/repositories/enrollment_repository.dart';
import 'features/enrollment/domain/usecases/enroll_in_course.dart';
import 'features/enrollment/domain/usecases/get_enrollments.dart';
import 'features/enrollment/domain/usecases/process_payment.dart';
import 'features/enrollment/presentation/bloc/enrolling/enroll_bloc.dart';
import 'features/enrollment/presentation/bloc/enrollments/enrollment_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/payment/data/datasources/payment_remote_data_source.dart';
import 'features/payment/data/repositories/payment_repository_impl.dart';
import 'features/payment/domain/repositories/payment_repository.dart';
import 'features/payment/domain/usecases/create_deposit_request.dart';
import 'features/payment/domain/usecases/get_deposit_methods.dart';
import 'features/payment/presentation/bloc/deposit_methods/deposit_methods_bloc.dart';
import 'features/profile/data/datasources/profile_remote_data_source.dart';
import 'features/profile/data/repositories/profile_repository.dart';
import 'features/profile/domain/entity/interests.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/create_profile.dart';
import 'features/profile/domain/usecases/get_interests.dart';
import 'features/profile/domain/usecases/get_profile_images.dart';
import 'features/profile/domain/usecases/get_studyfields.dart';
import 'features/profile/domain/usecases/get_universities.dart';
import 'features/profile/domain/usecases/save_user_interests_usecase.dart';
import 'features/profile/domain/usecases/upload_profile_image.dart';
import 'features/profile/presentation/bloc/create_profile/create_profile_bloc.dart';
import 'features/profile/presentation/bloc/interest_rating/interest_rating_bloc.dart';
import 'features/profile/presentation/bloc/interest_selection/interest_selection_bloc.dart';
import 'features/profile/presentation/bloc/profile_image/profile_image_bloc.dart';
import 'features/profile/presentation/bloc/university_and_study_field_selection/university_studyfield_bloc.dart';
import 'features/search/data/datasources/search_remote_datasource.dart';
import 'features/search/data/repositories/search_repository_impl.dart';
import 'features/search/domain/repositories/search_repository.dart';
import 'features/search/domain/usecases/search_courses_usecase.dart';
import 'features/search/presentation/bloc/search_bloc.dart';
import 'features/security_question/data/datasources/security_question_remote_data_source.dart';
import 'features/security_question/data/repositories/security_question_repository_impl.dart';
import 'features/security_question/domain/repositories/security_question_repository.dart';
import 'features/security_question/domain/usecases/get_security_questions_usecase.dart';
import 'features/security_question/domain/usecases/submit_security_answer_usecase.dart';
import 'features/security_question/presentation/bloc/security_question_bloc.dart';
import 'package:project2/features/reset_password/data/datasources/reset_password_datasource.dart';
import 'package:project2/features/reset_password/data/repositories/reset_password_repository_im.dart';
import 'package:project2/features/reset_password/domain/repositories/reset_passwor_repository.dart';
import 'package:project2/features/reset_password/domain/usecases/request_question.dart';
import 'package:project2/features/reset_password/presentation/bloc/answar_security_question/answar_security_qu_bloc.dart';
import 'package:project2/features/reset_password/presentation/bloc/new_password/new_password_bloc.dart';
import 'package:project2/features/reset_password/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'features/wallet/data/datasourses/wallet_remote_data_source.dart';
import 'features/wallet/data/repositories/wallet_repository_impl.dart';
import 'features/wallet/domain/repositories/wallet_repository.dart';
import 'features/wallet/domain/usecases/get_transactions.dart';
import 'features/wallet/domain/usecases/get_wallet.dart';
import 'features/wallet/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'features/wallet/presentation/bloc/wallet_bloc.dart';
import 'features/wishlist/data/datasources/wishlist_remote_datasource.dart';
import 'features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'features/wishlist/domain/repositories/wishlist_repository.dart';
import 'features/wishlist/domain/usecases/get_wishlists.dart';
import 'features/wishlist/domain/usecases/toggle_wishlist.dart';
import 'features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'localization/localization_bloc/localization_bloc.dart';
import 'localization/app_localizations.dart';
import 'localization/localization_bloc/localization_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Localization
  getIt.registerSingleton<LocalizationBloc>(
    LocalizationBloc(prefs: getIt<SharedPreferences>()),
  );

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

  // Home
  getIt.registerFactory(() => HomeBloc());

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

  // Courses
  // Courses Bloc
  getIt.registerFactory(
    () => CoursesBloc(getCourses: getIt()),
  );

// GetCourses use case
  getIt.registerLazySingleton(() => GetCourses(getIt()));

  // Schedule use case
  getIt.registerLazySingleton(() => GetCourseSchedule(getIt()));

  // Schedule BLoC
  getIt.registerFactory(() => CourseScheduleBloc(getCourseSchedule: getIt()));

  //Profile Feature
  getIt.registerFactory(() => ProfileBloc(getProfile: getIt()));

  getIt.registerLazySingleton(() => GetProfile(getIt()));
  // Repository
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(getIt()),
  );

  // Profile Feature - NEW Create Profile dependencies
  getIt.registerFactory(() => CreateProfileBloc(createProfile: getIt()));
  getIt.registerFactory(() => UniversityStudyfieldBloc(
        getUniversities: getIt(),
        getStudyfields: getIt(),
      ));

  getIt.registerLazySingleton(() => CreateProfile(getIt()));
  getIt.registerLazySingleton(() => GetUniversities(getIt()));
  getIt.registerLazySingleton(() => GetStudyfields(getIt()));

  // Use cases
  getIt.registerLazySingleton(() => UploadProfileImage(getIt()));
  getIt.registerLazySingleton(() => GetProfileImages(getIt())); // Add this

  // BLoC
  getIt.registerFactory(
    () => ProfileImageBloc(
      uploadProfileImage: getIt(),
      getProfileImages: getIt(), // Add this
    ),
  );

// Use cases
  getIt.registerLazySingleton(() => GetInterestsUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => SaveUserInterestsUseCase(repository: getIt()));

// Blocs
  getIt.registerFactory(
      () => InterestSelectionBloc(getInterestsUseCase: getIt()));
  getIt.registerFactoryParam<InterestRatingBloc, List<InterestEntity>, void>(
    (interests, _) => InterestRatingBloc(
      saveUserInterestsUseCase: getIt(),
      interests: interests,
    ),
  );

  // Wishlist BLoC
  getIt.registerFactory(
    () => WishlistBloc(
      toggleWishlist: getIt(),
      getWishlists: getIt(),
    ),
  );

  // Wishlist Use cases
  getIt.registerLazySingleton(() => ToggleWishlist(getIt()));
  getIt.registerLazySingleton(() => GetWishlists(getIt()));

  // Wishlist Repository
  getIt.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(remoteDataSource: getIt()),
  );

  // Wishlist Data sources
  getIt.registerLazySingleton<WishlistRemoteDataSource>(
    () => WishlistRemoteDataSourceImpl(client: getIt()),
  );

  // Deposit Request BLoC
  getIt.registerFactory(
    () => DepositRequestBloc(
      createDepositRequest: getIt(),
    ),
  );

  // Deposit Request Use cases
  getIt.registerLazySingleton(() => CreateDepositRequest(getIt()));

  // Deposit Request Repository
  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(getIt()),
  );

  // Deposit Request Data sources
  getIt.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(getIt()),
  );

  // Enrollment
  getIt.registerFactory(
    () => EnrollBloc(enrollInCourse: getIt()),
  );

  getIt.registerLazySingleton(() => EnrollInCourse(getIt()));

  getIt.registerLazySingleton<EnrollmentRepository>(
    () => EnrollmentRepositoryImpl(remoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<EnrollmentRemoteDataSource>(
    () => EnrollmentRemoteDataSourceImpl(client: getIt()),
  );

  //Wallet
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

  //Deposit Method
  getIt.registerFactory(
    () => DepositBloc(getDepositMethods: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetDepositMethods(getIt()));

  // // Repository
  // getIt.registerLazySingleton<DepositMethodRepository>(
  //       () => DepositMethodRepositoryImpl(remoteDataSource: getIt()),
  // );

  // // Data sources
  // getIt.registerLazySingleton<DepositMethodRemoteDataSource>(
  //       () => DepositMethodRemoteDataSourceImpl(client: getIt()),
  // );

  //Enrollment
  // Bloc
  getIt.registerFactory(() => EnrollmentBloc(
        getEnrollments: getIt(),
        processPayment: getIt(),
      ));
  // Use cases
  getIt.registerLazySingleton(() => GetEnrollments(getIt()));
  getIt.registerLazySingleton(() => ProcessPayment(getIt()));

  // Deposit Request Use cases
  getIt.registerLazySingleton(() => SearchCoursesUseCase(getIt()));

  // Deposit Request Repository
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(remoteDataSource: getIt()),
  );

  // Deposit Request Data sources
  getIt.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(getIt()),
  );

  // Deposit Request BLoC
  getIt.registerFactory(
    () => SearchBloc(
      searchCoursesUseCase: getIt(),
    ),
  );
}
