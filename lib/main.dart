import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project2/features/auth/presentation/pages/login_wrapper.dart';
import 'package:project2/features/notifications/presentation/pages/notifications_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/background_notification_service.dart';
import 'core/services/notification_service.dart';
import 'dependencies.dart';
// import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/courses/data/models/department_model.dart';
import 'features/courses/presentation/pages/departments_page.dart';
// import 'features/enrollment/presentation/pages/lessons_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/notifications/presentation/bloc/notification_bloc.dart';
// import 'features/search/presentation/pages/search_screen.dart';
import 'features/notifications/presentation/bloc/notification_event.dart';
import 'features/spalsh_screen/presentation/pages/splash_screen.dart';
import 'features/start/presentation/pages/start_page.dart';
import 'l10n/generated/app_localizations.dart';
import 'localization/domain/entities/language.dart';
import 'localization/presentation/localization_bloc/localization_bloc.dart';
import 'localization/presentation/localization_bloc/localization_event.dart';
import 'localization/presentation/localization_bloc/localization_state.dart';
import 'theme/presentation/bloc/theme_bloc.dart';
import 'theme/presentation/bloc/theme_event.dart';
// import 'localization/app_localizations.dart';
// import 'localization/localization_bloc/localization_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // await NotificationService.initialize();
//   // // Initialize SharedPreferences
//   final sharedPreferences = await SharedPreferences.getInstance();
//   getIt.registerSingleton<SharedPreferences>(sharedPreferences);
//
//   // Setup all dependencies including localization
//   setupDependencies();
//   await NotificationService.initialize();
//   await BackgroundNotificationService.initialize();
//   // final token = "";
//   // final baseUrl = sharedPreferences.getString('base_url') ?? '10.0.2.2:8000';
//
//   // runApp(const MyApp());
//   // runApp(
//   //   BlocProvider(
//   //     create: (context) => NotificationBloc(
//   //       token: token,
//   //       baseUrl: baseUrl,
//   //       onNotificationReceived: (notification) async {
//   //         // Show local notification when received
//   //         await NotificationService.showNotification(notification);
//   //       },
//   //     ),
//   //     child: const MyApp(),
//   //   ),
//   // );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   late NotificationBloc _notificationBloc;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//
//     _notificationBloc = getIt<NotificationBloc>();
//
//     // Connect to notifications when app starts
//     _notificationBloc.add(ConnectToNotifications());
//
//     // Listen to background service notifications
//     _setupBackgroundServiceListener();
//   }
//
//   void _setupBackgroundServiceListener() {
//     FlutterBackgroundService().on('notification_received').listen((event) {
//       if (event != null) {
//         // Handle notification received from background service
//         print('Notification received from background: $event');
//         _notificationBloc.add(LoadLocalNotifications());
//       }
//     });
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//
//     switch (state) {
//       case AppLifecycleState.resumed:
//       // App is in foreground, connect to WebSocket
//         _notificationBloc.add(ConnectToNotifications());
//         break;
//       case AppLifecycleState.paused:
//       case AppLifecycleState.inactive:
//       // App is going to background, start background service
//         BackgroundNotificationService.startService();
//         break;
//       case AppLifecycleState.detached:
//       // App is being terminated
//         _notificationBloc.add(DisconnectFromNotifications());
//         break;
//       case AppLifecycleState.hidden:
//         break;
//     }
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _notificationBloc.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: _notificationBloc,
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         // locale: state.locale,
//         // supportedLocales: const [
//         //   Locale('en'),
//         //   Locale('ar'),
//         // ],
//         // localizationsDelegates: const [
//         //   AppLocalizations.delegate,
//         //   GlobalMaterialLocalizations.delegate,
//         // ],
//         theme: ThemeData(
//           fontFamily: 'Poppins',
//           textTheme: const TextTheme(
//             displayLarge:
//             TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//             bodyLarge: TextStyle(
//               fontSize: 16,
//               color: Colors.black87,
//               // Handle RTL for Arabic
//               // textDirection: state.locale.languageCode == 'ar'
//               //     ? TextDirection.rtl
//               //     : TextDirection.ltr,
//             ),
//           ),
//         ),
//         initialRoute: '/start',
//         routes: {
//           '/splashScreen': (context) => const SplashScreen(),
//           '/start': (context) => const StartPage(),
//           // '/start': (context) => const LessonsPage(
//           //       scheduleSlotId: 281,
//           //     ),
//           // '/login': (context) => const LoginPage(),
//           '/login': (context) => const AppWrapper(),
//           '/departments': (context) => const DepartmentsPage(),
//           '/notifications':(context) =>const NotificationsPage()
//           // '/search':(context) =>const SearchScreen(),
//         },
//       ),
//     );
//   }
// }
// main.dart - Fixed version

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  try {
    // Initialize Hive
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(DepartmentModelAdapter());

    print('Hive initialized successfully');
  } catch (e) {
    print('Error initializing Hive: $e');
    rethrow;
  }

  setupDependencies();

  // Initialize notification service
  await NotificationService.initialize();
  await NotificationService.requestPermissions();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late NotificationBloc _notificationBloc;
  late LocalizationBloc _localizationBloc;
  late ThemeBloc _themeBloc;
  late AuthBloc _authBloc; // Add AuthBloc

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _notificationBloc = getIt<NotificationBloc>();
    _localizationBloc = getIt<LocalizationBloc>();
    _themeBloc = getIt<ThemeBloc>();
    _authBloc = getIt<AuthBloc>(); // Initialize AuthBloc

    // Start notification service when app starts
    NotificationService.startService();

    // Connect to notifications in foreground
    _notificationBloc.add(NotificationConnect());
    _localizationBloc.add(LoadCurrentLanguage());
    _themeBloc.add(const LoadTheme());

    // Check authentication status on app startup
    _authBloc.add(CheckAuthStatusRequested());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _notificationBloc.close();
    _localizationBloc.close();
    _themeBloc.close();
    _authBloc.close(); // Close AuthBloc
    Hive.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
      // App is in foreground
        _notificationBloc.add(NotificationConnect());
        // Re-check auth status when app resumes
        _authBloc.add(CheckAuthStatusRequested());
        break;
      case AppLifecycleState.paused:
      // App is in background
        _notificationBloc.add(NotificationDisconnect());
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _notificationBloc),
        BlocProvider.value(value: _localizationBloc),
        BlocProvider.value(value: _themeBloc),
        BlocProvider.value(value: _authBloc), // Add AuthBloc to providers
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, localizationState) {
          Locale currentLocale = const Locale('en');

          if (localizationState is LocalizationLoaded) {
            currentLocale = Locale(localizationState.currentLanguage.code);
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,

            // Localization configuration
            locale: currentLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: Language.supportedLanguages
                .map((language) => Locale(language.code))
                .toList(),

            theme: ThemeData(
              fontFamily: 'Poppins',
              textTheme: const TextTheme(
                displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                bodyLarge: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),

            // Use home instead of initialRoute for dynamic routing
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                // Show loading screen while checking auth status
                if (authState is AuthInitial || authState is AuthLoading) {
                  return const SplashScreen(); // or loading screen
                }

                // If user is authenticated and wants to stay signed in, go directly to home
                if (authState is AuthAuthenticated) {
                  return const HomePage();
                }

                // If user has saved credentials, still show start page but with quick login options
                // The start page will handle showing the login modal with saved credentials
                return const StartPage();
              },
            ),

            // Keep your existing routes for navigation
            routes: {
              '/splashScreen': (context) => const SplashScreen(),
              '/start': (context) => const StartPage(),
              '/login': (context) => const AppWrapper(),
              '/departments': (context) => const DepartmentsPage(),
              '/notifications': (context) => const NotificationsPage(),
              '/home': (context) => const HomePage(),
            },
          );
        },
      ),
    );
  }
}


//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => getIt<LocalizationBloc>(),
//         ),
//       ],
//       child: BlocBuilder<LocalizationBloc, LocalizationState>(
//         builder: (context, state) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             locale: state.locale,
//             supportedLocales: const [
//               Locale('en'),
//               Locale('ar'),
//             ],
//             localizationsDelegates: const [
//               AppLocalizations.delegate,
//               GlobalMaterialLocalizations.delegate,
//             ],
//             theme: ThemeData(
//               fontFamily: 'Poppins',
//               textTheme: const TextTheme(
//                 displayLarge:
//                     TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//                 bodyLarge: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black87,
//                   // Handle RTL for Arabic
//                   // textDirection: state.locale.languageCode == 'ar'
//                   //     ? TextDirection.rtl
//                   //     : TextDirection.ltr,
//                 ),
//               ),
//             ),
//             initialRoute: '/start',
//             routes: {
//               '/splashScreen': (context) => const SplashScreen(),
//               '/start': (context) => const StartPage(),
//               // '/start': (context) => const LessonsPage(
//               //       scheduleSlotId: 281,
//               //     ),
//               // '/login': (context) => const LoginPage(),
//               '/login': (context) => const AppWrapper(),
//               '/departments': (context) => const DepartmentsPage(),
//               // '/search':(context) =>const SearchScreen(),
//             },
//           );
//         },
//       ),
//     );
//   }
// }
