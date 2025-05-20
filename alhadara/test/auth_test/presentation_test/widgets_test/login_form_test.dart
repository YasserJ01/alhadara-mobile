import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:alhadara/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:alhadara/features/auth/presentation/widgets/login_form.dart';
// Import your app files

// Generate mock bloc
@GenerateMocks([AuthBloc])
import 'login_form_test.mocks.dart';

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  testWidgets('should display login form elements', (WidgetTester tester) async {
    // Arrange
    when(mockAuthBloc.state).thenReturn(AuthInitial());
    when(mockAuthBloc.stream).thenAnswer((_) => Stream.empty());

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: Scaffold(
            body: LoginFormContent(),
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('let\'s get started'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('forgot password ?'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.text('Don\'t have an account ?'), findsOneWidget);
    expect(find.text(' SIGN UP'), findsOneWidget);
  });

  testWidgets('should show loading indicator when state is AuthLoading', (WidgetTester tester) async {
    // Arrange
    when(mockAuthBloc.state).thenReturn(AuthLoading());
    when(mockAuthBloc.stream).thenAnswer((_) => Stream.fromIterable([AuthLoading()]));

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: Scaffold(
            body: LoginFormContent(),
          ),
        ),
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should dispatch LoginWithPhoneRequested when login button is pressed', (WidgetTester tester) async {
    // Arrange
    when(mockAuthBloc.state).thenReturn(AuthInitial());
    when(mockAuthBloc.stream).thenAnswer((_) => Stream.empty());

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: Scaffold(
            body: LoginFormContent(),
          ),
        ),
      ),
    );

    // Fill form fields
    await tester.enterText(find.byType(TextFormField).at(0), '0991234567');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');

    // Tap login button
    await tester.tap(find.text('LOGIN'));
    await tester.pump();

    // Assert
    verify(mockAuthBloc.add(LoginWithPhoneRequested('0991234567', 'password123'))).called(1);
  });

  testWidgets('should call onSignUpPressed callback when SIGN UP is tapped', (WidgetTester tester) async {
    // Arrange
    when(mockAuthBloc.state).thenReturn(AuthInitial());
    when(mockAuthBloc.stream).thenAnswer((_) => Stream.empty());
    bool signUpPressed = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: Scaffold(
            body: LoginFormContent(
              onSignUpPressed: () {
                signUpPressed = true;
              },
            ),
          ),
        ),
      ),
    );

    // Tap SIGN UP text
    await tester.tap(find.text(' SIGN UP'));
    await tester.pump();

    // Assert
    expect(signUpPressed, isTrue);
  });

  testWidgets('should show SnackBar when state is AuthFailure', (WidgetTester tester) async {
    // Arrange
    when(mockAuthBloc.state).thenReturn(AuthInitial());
    when(mockAuthBloc.stream).thenAnswer((_) => Stream.fromIterable([
      AuthFailure('Invalid credentials')
    ]));

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: Scaffold(
            body: LoginFormContent(),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(); // Additional pump to process the listener

    // Assert
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Invalid credentials'), findsOneWidget);
  });
}
