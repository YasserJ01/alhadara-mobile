// auth/presentation/bloc/register_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project2/errors/expections.dart';
import 'package:project2/features/auth/domain/entities/user_register_entity.dart';

import '../../../domain/usecases/register_usecase.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase}) : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<RegisterState> emit,
  ) async {
    if (event.password != event.confirm_password) {
      emit(const RegisterFailure("Passwords do not match"));
      return;
    }



    emit(RegisterLoading());
    try {
      final authToken = await registerUseCase(
        event.firstName,
        event.middleName,
        event.lastName,
        event.phone,
        event.password,
        event.confirm_password
      );
      emit(RegisterSuccess(authToken));
    } on ValidationnException catch (e) {
      emit(RegisterFailure(e.errors));
    } on ServerException catch (e){
      emit(RegisterFailure(e.message));
    }catch (e) {
        // Handle any other errors
        emit(RegisterFailure(e.toString()));
      }
    // on ValidationnException catch (e) {
    //   emit(RequestSecurityQuestionError(message: e.errors));
    // } on CacheException catch (e) {
    //   emit(RequestSecurityQuestionError(message: e.message));
    // } on ServerException catch (e) {
    //   emit(RequestSecurityQuestionError(message: e.message));
    // } catch (e) {
    //   // Handle any other errors
    //   emit(RequestSecurityQuestionError(
    //       message: 'An unexpected error occurred'));
    // }
  }
}
