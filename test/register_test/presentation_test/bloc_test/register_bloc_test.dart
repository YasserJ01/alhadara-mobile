import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project2/errors/expections.dart';
import 'package:project2/features/auth/domain/usecases/register_usecase.dart';
import 'package:project2/features/auth/presentation/bloc/register/register_bloc.dart';

import 'register_bloc_test.mocks.dart';



@GenerateMocks([RegisterUseCase])
void main() {
  late RegisterBloc registerBloc;
  late MockRegisterUseCase mockRegisterUseCase;

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    registerBloc = RegisterBloc(registerUseCase: mockRegisterUseCase);
  });

  group('RegisterBloc', () {
    const String tFirstName = 'John';
    const String tMiddleName = 'Middle';
    const String tLastName = 'Doe';
    const String tPhone = '1234567890';
    const String tPassword = 'password123';
    const String tConfirmPassword = 'password123';
    const String tAccessToken = 'test_access_token';

    test('initial state should be RegisterInitial', () {
      expect(registerBloc.state, equals(RegisterInitial()));
    });

    blocTest<RegisterBloc, RegisterState>(
      'should emit [RegisterLoading, RegisterSuccess] when registration succeeds',
      build: () {
        when(mockRegisterUseCase(
          any,
          any,
          any,
          any,
          any,
          any,
        )).thenAnswer((_) async => tAccessToken);
        return registerBloc;
      },
      act: (bloc) => bloc.add(const RegisterRequested(
        firstName: tFirstName,
        middleName: tMiddleName,
        lastName: tLastName,
        phone: tPhone,
        password: tPassword,
        confirm_password: tConfirmPassword,
      )),
      expect: () => [
        RegisterLoading(),
        const RegisterSuccess(tAccessToken),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'should emit [RegisterFailure] when passwords do not match',
      build: () => registerBloc,
      act: (bloc) => bloc.add(const RegisterRequested(
        firstName: tFirstName,
        middleName: tMiddleName,
        lastName: tLastName,
        phone: tPhone,
        password: tPassword,
        confirm_password: 'different_password',
      )),
      expect: () => [
        const RegisterFailure('Passwords do not match'),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'should emit [RegisterLoading, RegisterFailure] when ValidationException occurs',
      build: () {
        when(mockRegisterUseCase(
          any,
          any,
          any,
          any,
          any,
          any,
        )).thenThrow(ValidationnException('Phone number already exists'));
        return registerBloc;
      },
      act: (bloc) => bloc.add(const RegisterRequested(
        firstName: tFirstName,
        middleName: tMiddleName,
        lastName: tLastName,
        phone: tPhone,
        password: tPassword,
        confirm_password: tConfirmPassword,
      )),
      expect: () => [
        RegisterLoading(),
        const RegisterFailure('Phone number already exists'),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'should emit [RegisterLoading, RegisterFailure] when ServerException occurs',
      build: () {
        when(mockRegisterUseCase(
          any,
          any,
          any,
          any,
          any,
          any,
        )).thenThrow(ServerException('Server error'));
        return registerBloc;
      },
      act: (bloc) => bloc.add(const RegisterRequested(
        firstName: tFirstName,
        middleName: tMiddleName,
        lastName: tLastName,
        phone: tPhone,
        password: tPassword,
        confirm_password: tConfirmPassword,
      )),
      expect: () => [
        RegisterLoading(),
        const RegisterFailure('Server error'),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'should emit [RegisterLoading, RegisterFailure] when unexpected exception occurs',
      build: () {
        when(mockRegisterUseCase(
          any,
          any,
          any,
          any,
          any,
          any,
        )).thenThrow(Exception('Unexpected error'));
        return registerBloc;
      },
      act: (bloc) => bloc.add(const RegisterRequested(
        firstName: tFirstName,
        middleName: tMiddleName,
        lastName: tLastName,
        phone: tPhone,
        password: tPassword,
        confirm_password: tConfirmPassword,
      )),
      expect: () => [
        RegisterLoading(),
        const RegisterFailure('Exception: Unexpected error'),
      ],
    );
  });

  tearDown(() {
    registerBloc.close();
  });
}