// dependencies.dart

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
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
import 'package:project2/features/quiz/presentation/bloc/quiz_list/quiz_list_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/cache/cache_manager.dart';
import 'core/network/api_client.dart';
import 'core/network/network_info.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/datasources/verification_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_with_phone_usecase.dart';
import 'features/auth/domain/usecases/refresh_token_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/domain/usecases/start_verification_usecase.dart';
import 'features/auth/domain/usecases/submit_verification_usecase.dart';
import 'features/auth/domain/usecases/verify_captcha.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/captch/captcha_bloc.dart';
import 'features/auth/presentation/bloc/register/register_bloc.dart';
import 'features/auth/presentation/bloc/verification/verification_bloc.dart';
import 'features/complaints/data/datasources/complaint_remote_datasource.dart';
import 'features/complaints/data/repositories/complaint_repository_impl.dart';
import 'features/complaints/domain/repositories/complaint_repository.dart';
import 'features/complaints/domain/usecases/get_complaints.dart';
import 'features/complaints/domain/usecases/submit_complaint.dart';
import 'features/complaints/presentation/bloc/complaint_bloc.dart';
import 'features/courses/data/datasources/departments_local_data_source.dart';
import 'features/courses/domain/usecases/get_deals_courses.dart';
import 'features/courses/domain/usecases/get_recommended_courses.dart';
import 'features/courses/presentation/bloc/course_schedule_bloc/course_schedule_bloc.dart';
import 'features/enrollment/data/datasources/enrollment_remote_data_source.dart';
import 'features/enrollment/data/repositories/enrollment_repository_impl.dart';
import 'features/enrollment/domain/repositories/enrollment_repository.dart';
import 'features/enrollment/domain/usecases/create_lesson_combo.dart';
import 'features/enrollment/domain/usecases/create_private_lesson_request.dart';
import 'features/enrollment/domain/usecases/delete_private_lesson_request.dart';
import 'features/enrollment/domain/usecases/enroll_in_course.dart';
import 'features/enrollment/domain/usecases/get_enrollment_details.dart';
import 'features/enrollment/domain/usecases/get_enrollments.dart';
import 'features/enrollment/domain/usecases/get_homework_by_lesson_id.dart';
import 'features/enrollment/domain/usecases/get_lesson_summaries.dart';
import 'features/enrollment/domain/usecases/get_lessons.dart';
import 'features/enrollment/domain/usecases/get_news_feed_usecase.dart';
import 'features/enrollment/domain/usecases/get_private_lesson_requests.dart';
import 'features/enrollment/domain/usecases/pick_proposed_option.dart';
import 'features/enrollment/domain/usecases/process_payment.dart';
import 'features/enrollment/domain/usecases/publish_post_usecase.dart';
import 'features/enrollment/presentation/bloc/bulletin_post/bulletin_post_bloc.dart';
import 'features/enrollment/presentation/bloc/enrolling/enroll_bloc.dart';
import 'features/enrollment/presentation/bloc/enrollments/enrollment_bloc.dart';
import 'features/enrollment/presentation/bloc/homeworks/homework_bloc.dart';
import 'features/enrollment/presentation/bloc/lesson_combo/lesson_combo_bloc.dart';
import 'features/enrollment/presentation/bloc/lesson_summary/lesson_summary_bloc.dart';
import 'features/enrollment/presentation/bloc/lessons/lessons_bloc.dart';
import 'features/enrollment/presentation/bloc/news_feed/news_feed_bloc.dart';
import 'features/entrance_exam/data/datasources/entrance_exam_remote_data_source.dart';
import 'features/entrance_exam/data/repositories/entrance_exam_repository_impl.dart';
import 'features/entrance_exam/domain/repositories/entrance_exam_repository.dart';
import 'features/entrance_exam/presentation/bloc/entrance_exam_bloc.dart';
import 'features/feedback/data/datasources/feedback_remote_data_source.dart';
import 'features/feedback/data/repositories/feedback_repository_impl.dart';
import 'features/feedback/domain/repositories/feedback_repository.dart';
import 'features/feedback/domain/usecases/submit_feedback_usecase.dart';
import 'features/feedback/presentation/bloc/feedback_bloc.dart';
import 'features/hall_services/data/datasources/hall_booking_remote_data_source.dart';
import 'features/hall_services/data/repositories/hall_booking_repository_impl.dart';
import 'features/hall_services/domain/repositories/hall_booking_repository.dart';
import 'features/hall_services/domain/usecases/create_booking_usecase.dart.dart';
import 'features/hall_services/domain/usecases/get_services_usecase.dart';
import 'features/hall_services/domain/usecases/search_halls_usecase.dart';
import 'features/hall_services/presentation/bloc/hall_booking_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/loyalty_points/data/datasources/loyalty_points_remote_data_source.dart';
import 'features/loyalty_points/data/repositories/loyalty_points_repository_impl.dart';
import 'features/loyalty_points/domain/repositories/loyalty_points_repository.dart';
import 'features/loyalty_points/domain/usecases/get_loyalty_points.dart';
import 'features/loyalty_points/presentation/bloc/loyalty_points_bloc.dart';
import 'features/notifications/data/datasources/notification_local_data_source.dart';
import 'features/notifications/data/datasources/notification_remote_data_source.dart';
import 'features/notifications/data/repositories/notification_repository_impl.dart';
import 'features/notifications/domain/repositories/notification_repository.dart';
import 'features/notifications/domain/usecases/connect_notifications.dart';
import 'features/notifications/domain/usecases/disconnect_notifications.dart';
import 'features/notifications/domain/usecases/get_local_notifications.dart';
import 'features/notifications/domain/usecases/listen_to_notifications.dart';
import 'features/notifications/domain/usecases/mark_notification_read.dart';
import 'features/notifications/presentation/bloc/notification_bloc.dart';
import 'features/payment/data/datasources/payment_remote_data_source.dart';
import 'features/payment/data/repositories/payment_repository_impl.dart';
import 'features/payment/domain/repositories/payment_repository.dart';
import 'features/payment/domain/usecases/create_deposit_request.dart';
import 'features/payment/domain/usecases/create_withdrawal_request.dart';
import 'features/payment/domain/usecases/get_deposit_methods.dart';
import 'features/payment/presentation/bloc/deposit_methods/deposit_methods_bloc.dart';
import 'features/payment/presentation/bloc/withdraw/withdrawal_bloc.dart';
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
import 'features/quiz/data/datasources/quiz_remote_datasource.dart';
import 'features/quiz/data/repositories/quiz_repository_impl.dart';
import 'features/quiz/domain/repositories/quiz_repository.dart';
import 'features/quiz/domain/usecases/get_quiz_questions_usecase.dart';
import 'features/quiz/domain/usecases/get_quizzes_usecase.dart';
import 'features/quiz/domain/usecases/start_quiz_attempt_usecase.dart';
import 'features/quiz/domain/usecases/submit_quiz_answers_usecase.dart';
import 'features/quiz/presentation/bloc/quiz_attempt/quiz_attempt_bloc.dart';
import 'features/quiz/presentation/bloc/quiz_questions/quiz_questions_bloc.dart';
import 'features/quiz/presentation/bloc/quiz_submission/quiz_submission_bloc.dart';
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
import 'localization/data/datasources/language_local_data_source.dart';
import 'localization/data/repositories/language_repository_impl.dart';
import 'localization/domain/repositories/language_repository.dart';
import 'localization/domain/usecases/get_current_language.dart';
import 'localization/domain/usecases/save_language.dart';
import 'localization/presentation/localization_bloc/localization_bloc.dart';
import 'theme/data/datasources/theme_local_datasource.dart';
import 'theme/data/repositories/theme_repository_impl.dart';
import 'theme/domain/repositories/theme_repository.dart';
import 'theme/domain/usecases/get_current_theme.dart';
import 'theme/domain/usecases/save_theme.dart';
import 'theme/domain/usecases/toggle_theme.dart';
import 'theme/presentation/bloc/theme_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  if (!getIt.isRegistered<SharedPreferences>()) {
    throw Exception(
        'SharedPreferences must be registered before calling setupDependencies');
  }
  // Language
  // Data Sources
  getIt.registerLazySingleton<LanguageLocalDataSource>(
    () => LanguageLocalDataSourceImpl(getIt<SharedPreferences>()),
  );

  // Repositories
  getIt.registerLazySingleton<LanguageRepository>(
    () => LanguageRepositoryImpl(getIt<LanguageLocalDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton(
      () => GetCurrentLanguage(getIt<LanguageRepository>()));
  getIt.registerLazySingleton(() => SaveLanguage(getIt<LanguageRepository>()));

  // Blocs
  getIt.registerFactory(() => LocalizationBloc(
        getCurrentLanguage: getIt<GetCurrentLanguage>(),
        saveLanguage: getIt<SaveLanguage>(),
      ));

  getIt.registerSingleton<http.Client>(http.Client());
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: getIt<Connectivity>(),
      connectionChecker: getIt<InternetConnectionChecker>(),
    ),
  );
  getIt.registerLazySingleton<CacheManager>(() => CacheManagerImpl());

  // API Client
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(getIt<http.Client>(), getIt<AuthRemoteDataSource>()),
  );
  // Auth Feature
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(getIt<http.Client>()),
  );
  getIt.registerLazySingleton<VerificationRemoteDataSource>(
    () => VerificationRemoteDataSourceImpl(
      getIt(),
      getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt(),
    ),
  );
  // getIt.registerSingleton<AuthRepository>(
  //   AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  // );
  getIt.registerSingleton<LoginWithPhoneUseCase>(
    LoginWithPhoneUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RefreshTokenUseCase>(
    () => RefreshTokenUseCase(getIt<AuthRepository>()),
  );

  // BLoCs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginWithPhoneUseCase: getIt<LoginWithPhoneUseCase>(),
      refreshTokenUseCase: getIt<RefreshTokenUseCase>(),
      authRepository: getIt<AuthRepository>(),
    ),
  );
  // getIt.registerFactory(
  //   () => AuthBloc(
  //     // loginWithPhoneUseCase: loginUseCase,
  //     refreshTokenUseCase: getIt<RefreshTokenUseCase>(),
  //     authRepository: getIt<AuthRepositoryImpl>(),
  //     loginWithPhoneUseCase: getIt<LoginWithPhoneUseCase>(),
  //   ),
  // );

  getIt.registerSingleton<RegisterUseCase>(
    RegisterUseCase(getIt<AuthRepository>()),
  );
  getIt.registerFactory(
      () => RegisterBloc(registerUseCase: getIt<RegisterUseCase>()));

  //Captcha bloc
  getIt.registerLazySingleton(
      () => VerifyCaptchaUseCase(getIt<AuthRepository>()));
  getIt.registerFactory(
      () => CaptchaBloc(remoteDataSource: getIt<AuthRemoteDataSource>()));

  // Security Question Feature
  getIt.registerFactory<SecurityQuestionRemoteDataSource>(
    () => SecurityQuestionRemoteDataSourceImpl(getIt(), getIt()),
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

  // Use cases
  getIt.registerLazySingleton(
      () => StartVerificationUseCase(repository: getIt()));
  getIt.registerLazySingleton(
      () => SubmitVerificationUseCase(repository: getIt()));

  // Bloc
  getIt.registerFactory(() => VerificationBloc(
        startVerificationUseCase: getIt(),
        submitVerificationUseCase: getIt(),
      ));
  // Home
  getIt.registerLazySingleton(
      () => GetRecommendedCourses(getIt<CoursesRepository>()));
  getIt
      .registerLazySingleton(() => GetDealsCourses(getIt<CoursesRepository>()));
  getIt.registerFactory(() => HomeBloc(
        getRecommendedCourses: getIt<GetRecommendedCourses>(),
    getDealsCourses: getIt<GetDealsCourses>()
      ));
  // Data sources
  getIt.registerLazySingleton<CoursesRemoteDataSource>(
    () => CoursesRemoteDataSourceImpl(getIt(), getIt()),
  );
  // Local Data Source
  getIt.registerLazySingleton<DepartmentsLocalDataSource>(
    () => DepartmentsLocalDataSourceImpl(),
  );

  // Repository
  getIt.registerLazySingleton<CoursesRepository>(
    () => DepartmentRepositoryImpl(
      remoteDataSource: getIt<CoursesRemoteDataSource>(),
      localDataSource: getIt<DepartmentsLocalDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
      cacheManager: getIt<CacheManager>(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetDepartments(getIt()));

  // Bloc
  getIt.registerFactory(
    () => DepartmentsBloc(
      getDepartments: getIt(),
      networkInfo: getIt<NetworkInfo>(),
    ),
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
    () => ProfileRemoteDataSourceImpl(getIt(), getIt()),
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
    () => WishlistRemoteDataSourceImpl(getIt(), getIt()),
  );

  // Deposit Request BLoC
  getIt.registerFactory(
    () => DepositRequestBloc(
      createDepositRequest: getIt(),
    ),
  );

  getIt.registerFactory(
    () => WithdrawalBloc(
      createWithdrawalRequest: getIt(),
    ),
  );

  // Deposit Request Use cases
  getIt.registerLazySingleton(() => CreateDepositRequest(getIt()));

  getIt.registerLazySingleton(() => CreateWithdrawalRequest(getIt()));

  // Deposit Request Repository
  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(getIt()),
  );

  // Deposit Request Data sources
  getIt.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(getIt(), getIt()),
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
    () => EnrollmentRemoteDataSourceImpl(getIt(), getIt()),
  );

  // Lessons Use case
  getIt.registerLazySingleton(() => GetLessons(getIt()));
  // Lessons Bloc
  getIt.registerFactory(() => LessonsBloc(getLessons: getIt()));

  // Homeworks Use cases
  getIt.registerLazySingleton(() => GetHomeworkByLessonId(getIt()));

  // Homeworks Blocs
  getIt.registerFactory(() => HomeworkBloc(getHomeworkByLessonId: getIt()));

  //Wallet
  // Data sources
  getIt.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(getIt(), getIt()),
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
        getEnrollmentDetails: getIt(),
      ));
  // Use cases
  getIt.registerLazySingleton(() => GetEnrollments(getIt()));
  getIt.registerLazySingleton(() => ProcessPayment(getIt()));
  getIt.registerLazySingleton(() => GetEnrollmentDetails(getIt()));

  // Lesson Summary Feature
  getIt.registerFactory(() => LessonSummaryBloc(getLessonSummaries: getIt()));
  getIt.registerLazySingleton(() => GetLessonSummaries(getIt()));

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

  //! Features - Notifications
  // BLoC
  getIt.registerFactory(
    () => NotificationBloc(
      connectToNotifications: getIt<ConnectToNotifications>(),
      disconnectFromNotifications: getIt<DisconnectFromNotifications>(),
      getNotifications: getIt<GetNotifications>(),
      listenToNotifications: getIt<ListenToNotifications>(),
      markNotificationAsRead: getIt<MarkNotificationAsRead>(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(
      () => ConnectToNotifications(getIt<NotificationRepository>()));
  getIt.registerLazySingleton(
      () => DisconnectFromNotifications(getIt<NotificationRepository>()));
  getIt.registerLazySingleton(
      () => GetNotifications(getIt<NotificationRepository>()));
  getIt.registerLazySingleton(
      () => ListenToNotifications(getIt<NotificationRepository>()));
  getIt.registerLazySingleton(
      () => MarkNotificationAsRead(getIt<NotificationRepository>()));

  // Data sources
  getIt.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<NotificationLocalDataSource>(
    () => NotificationLocalDataSourceImpl(
      sharedPreferences: getIt<SharedPreferences>(),
    ),
  );

  // Repository
  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      remoteDataSource: getIt<NotificationRemoteDataSource>(),
      localDataSource: getIt<NotificationLocalDataSource>(),
    ),
  );

  // QUIZZES
  // Data sources
  getIt.registerLazySingleton<QuizRemoteDataSource>(
    () => QuizRemoteDataSourceImpl(
      getIt(),
      getIt(),
    ),
  );

  // Repository
  getIt.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(
      remoteDataSource: getIt(),
    ),
  );
  // Use Cases
  getIt.registerLazySingleton(
    () => GetQuizQuestionsUseCase(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => StartQuizAttemptUseCase(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => GetQuizzesUseCase(
      repository: getIt(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton<SubmitQuizAnswersUseCase>(
    () => SubmitQuizAnswersUseCase(
      repository: getIt(),
    ),
  );
  // BLoCs
  getIt.registerFactory(
    () => QuizListBloc(
      getQuizzesUseCase: getIt<GetQuizzesUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => QuizAttemptBloc(
      startQuizAttemptUseCase: getIt<StartQuizAttemptUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => QuizQuestionsBloc(
      getQuizQuestionsUseCase: getIt<GetQuizQuestionsUseCase>(),
    ),
  );
  // BLoCs
  getIt.registerFactory<QuizSubmissionBloc>(
    () => QuizSubmissionBloc(
      submitQuizAnswersUseCase: getIt<SubmitQuizAnswersUseCase>(),
    ),
  );

  // News Feed
  // Use Case
  getIt.registerLazySingleton(() => GetNewsFeedUseCase(repository: getIt()));
  // Blocs
  getIt.registerFactory(
    () => NewsFeedBloc(
      getNewsFeedUseCase: getIt(),
      client: getIt(),
    ),
  );

  // TODO: Teacher Lesson/Homework/Attendance Combo
  // Use cases
  getIt.registerLazySingleton(() => CreateLessonCombo(repository: getIt()));

  // BLoCs
  getIt.registerFactory(() => LessonComboBloc(createLessonCombo: getIt()));

  // Teacher Post to Bulletin Board
  // Use cases
  getIt.registerLazySingleton(() => PublishPostUseCase(repository: getIt()));
  // BloC
  getIt.registerFactory(() => BulletinPostBloc(publishPostUseCase: getIt()));

  // Private lesson
  // Use Cases
  getIt.registerSingleton<CreatePrivateLessonRequest>(
    CreatePrivateLessonRequest(getIt<EnrollmentRepository>()),
  );
  getIt.registerSingleton<GetPrivateLessonRequests>(
    GetPrivateLessonRequests(getIt<EnrollmentRepository>()),
  );
  getIt.registerSingleton<PickProposedOption>(
    PickProposedOption(getIt<EnrollmentRepository>()),
  );
  getIt.registerSingleton<DeletePrivateLessonRequest>(
    DeletePrivateLessonRequest(getIt<EnrollmentRepository>()),
  );

  // Loyalty Points
  // Data Layer
  getIt.registerLazySingleton<LoyaltyPointsRemoteDataSource>(
    () => LoyaltyPointsRemoteDataSourceImpl(
      getIt(),
      getIt(),
    ),
  );

  getIt.registerLazySingleton<LoyaltyPointsRepository>(
    () => LoyaltyPointsRepositoryImpl(remoteDataSource: getIt()),
  );

// Domain Layer
  getIt.registerLazySingleton(() => GetLoyaltyPoints(getIt()));

// Presentation Layer
  getIt.registerFactory(() => LoyaltyPointsBloc(getLoyaltyPoints: getIt()));

  // Theme
  // Data sources
  getIt.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(sharedPreferences: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(localDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetCurrentTheme(getIt()));
  getIt.registerLazySingleton(() => ToggleTheme(getIt()));
  getIt.registerLazySingleton(() => SaveTheme(getIt()));

  // BLoC
  getIt.registerFactory(
    () => ThemeBloc(
      getCurrentTheme: getIt(),
      toggleTheme: getIt(),
      saveTheme: getIt(),
    ),
  );

  // Entrance Exam
  getIt.registerFactory(
    () => EntranceExamBloc(repository: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<EntranceExamRepository>(
    () => EntranceExamRepositoryImpl(remoteDataSource: getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<EntranceExamRemoteDataSource>(
    () => EntranceExamRemoteDataSourceImpl(client: getIt(), apiClient: getIt()),
  );

  //feedback
  getIt.registerFactory(
    () => FeedbackBloc(submitFeedbackUseCase: getIt<SubmitFeedbackUseCase>()),
  );

  getIt.registerLazySingleton(
      () => SubmitFeedbackUseCase(getIt<FeedbackRepository>()));

  getIt.registerLazySingleton<FeedbackRepository>(
    () => FeedbackRepositoryImpl(
        remoteDataSource: getIt<FeedbackRemoteDataSource>()),
  );
  getIt.registerLazySingleton<FeedbackRemoteDataSource>(
    () => FeedbackRemoteDataSourceImpl(client: getIt(), apiClient: getIt()),
  );
//complaint
  // BLoC
  getIt.registerFactory<ComplaintBloc>(
    () => ComplaintBloc(
      submitComplaint: getIt(),
      getComplaints: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => SubmitComplaintUseCase(getIt()));
  getIt.registerLazySingleton(() => GetComplaints(getIt()));

  // Repository
  getIt.registerLazySingleton<ComplaintRepository>(
    () => ComplaintRepositoryImpl(
      remoteDataSource: getIt(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<ComplaintRemoteDataSource>(
    () => ComplaintRemoteDataSource(),
  );

  //hall_services
  getIt.registerSingleton<HallBookingRemoteDataSource>(
    HallBookingRemoteDataSourceImpl(
        client: getIt<http.Client>(), apiClient: getIt()),
  );

  // Repositories
  getIt.registerSingleton<HallBookingRepository>(
    HallBookingRepositoryImpl(
        remoteDataSource: getIt<HallBookingRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerSingleton<SearchHallsUseCase>(
    SearchHallsUseCase(repository: getIt<HallBookingRepository>()),
  );
  getIt.registerSingleton<GetServicesUseCase>(
    GetServicesUseCase(repository: getIt<HallBookingRepository>()),
  );
  getIt.registerFactory(() => CreateBookingUseCase(repository: getIt()));

  // Bloc
  getIt.registerFactory<HallBookingBloc>(
    () => HallBookingBloc(
      searchHallsUseCase: getIt<SearchHallsUseCase>(),
      getServicesUseCase: getIt<GetServicesUseCase>(),
      createBookingUseCase: getIt(),
    ),
  );
}
