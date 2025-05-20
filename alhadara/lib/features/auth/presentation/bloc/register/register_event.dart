// auth/presentation/bloc/register_event.dart
part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterRequested extends RegisterEvent {
  final String firstName;
  final String middleName;
  final String lastName;
  final String phone;
  final String password;
  final String confirm_password;

  const RegisterRequested({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phone,
    required this.password,
    required this.confirm_password,
  });

  @override
  List<Object> get props => [
        firstName,
        middleName,
        lastName,
        phone,
        password,
        confirm_password,
      ];
}
