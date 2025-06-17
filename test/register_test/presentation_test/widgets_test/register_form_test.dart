import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project2/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:project2/features/auth/presentation/widgets/register_form.dart';
import 'register_form_test.mocks.dart';

@GenerateMocks([RegisterBloc])
void main() {
  late MockRegisterBloc mockRegisterBloc;

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
    when(mockRegisterBloc.state).thenReturn(RegisterInitial());
    when(mockRegisterBloc.stream)
        .thenAnswer((_) => Stream.fromIterable([RegisterInitial()]));
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<RegisterBloc>.value(
          value: mockRegisterBloc,
          child: const RegisterForm(),
        ),
      ),
    );
  }

  group('RegisterForm Widget', () {
    testWidgets('should render all form fields correctly', (tester) async {
      // arrange & act
      await tester.pumpWidget(createWidgetUnderTest());

      // assert
      expect(find.text('Register'), findsOneWidget);
      expect(find.text("let's get started"), findsOneWidget);
      expect(find.byKey(const Key('firstNameField')), findsOneWidget);
      expect(find.byKey(const Key('middleNameField')), findsOneWidget);
      expect(find.byKey(const Key('lastNameField')), findsOneWidget);
      expect(find.byKey(const Key('phoneField')), findsOneWidget);
      expect(find.byKey(const Key('passwordField')), findsOneWidget);
      expect(find.byKey(const Key('confirmPasswordField')), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should show validation error when form is submitted with empty fields',
            (tester) async {
          // arrange
          await tester.pumpWidget(createWidgetUnderTest());

          // act
          await tester.tap(find.byType(ElevatedButton));
          await tester.pump();

          // assert
          expect(find.text('Required field'), findsWidgets);
        });

    testWidgets('should trigger RegisterRequested event when form is valid and submitted',
            (tester) async {
          // arrange
          await tester.pumpWidget(createWidgetUnderTest());

          // Fill out the form
          await tester.enterText(find.byKey(const Key('firstNameField')), 'John');
          await tester.enterText(find.byKey(const Key('middleNameField')), 'Middle');
          await tester.enterText(find.byKey(const Key('lastNameField')), 'Doe');
          await tester.enterText(find.byKey(const Key('phoneField')), '1234567890');
          await tester.enterText(find.byKey(const Key('passwordField')), 'password123');
          await tester.enterText(
              find.byKey(const Key('confirmPasswordField')), 'password123');

          // act
          await tester.tap(find.byType(ElevatedButton));
          await tester.pump();

          // assert
          verify(mockRegisterBloc.add(any)).called(1);
        });

    testWidgets('should show loading indicator when state is RegisterLoading',
            (tester) async {
          // arrange
          when(mockRegisterBloc.state).thenReturn(RegisterLoading());
          when(mockRegisterBloc.stream)
              .thenAnswer((_) => Stream.fromIterable([RegisterLoading()]));

          // act
          await tester.pumpWidget(createWidgetUnderTest());

          // assert
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        });

    testWidgets('should toggle password visibility when suffix icon is tapped',
            (tester) async {
          // arrange
          await tester.pumpWidget(createWidgetUnderTest());

          // act
          await tester.tap(find.byIcon(Icons.visibility_off).first);
          await tester.pump();

          // assert
          expect(find.byIcon(Icons.visibility), findsOneWidget);
        });

    testWidgets('should show "Already have an account? Login" text',
            (tester) async {
          // arrange & act
          await tester.pumpWidget(createWidgetUnderTest());

          // assert
          expect(find.text('Already have an account ? '), findsOneWidget);
          expect(find.text('  Login'), findsOneWidget);
        });
  });

  tearDown(() {
    mockRegisterBloc.close();
  });
}