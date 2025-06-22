import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dependencies.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/courses/presentation/pages/departments_page.dart';
import 'features/search/presentation/pages/search_screen.dart';
import 'features/spalsh_screen/presentation/pages/splash_screen.dart';
import 'features/start/presentation/pages/start_page.dart';
import 'localization/app_localizations.dart';
import 'localization/localization_bloc/localization_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Setup all dependencies including localization
  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<LocalizationBloc>(),
        ),
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            theme: ThemeData(
              fontFamily: 'Poppins',
              textTheme: const TextTheme(
                displayLarge:  TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                bodyLarge: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  // Handle RTL for Arabic
                  // textDirection: state.locale.languageCode == 'ar'
                  //     ? TextDirection.rtl
                  //     : TextDirection.ltr,
                ),
              ),
            ),
            initialRoute: '/start',
            routes: {
              '/splashScreen': (context) => const SplashScreen(),
              '/start': (context) => const StartPage(),
              '/login': (context) => const LoginPage(),
              '/departments': (context) => const DepartmentsPage(),
              // '/search':(context) =>const SearchScreen(),
            },
          );
        },
      ),
    );
  }
}
