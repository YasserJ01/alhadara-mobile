import 'package:alhadara/features/enrollments/domain/entities/enrollment_entity.dart';
import 'package:alhadara/features/enrollments/domain/usecases/get_enrollments.dart';
import 'package:alhadara/features/enrollments/domain/usecases/process_payment.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'enrollment_event.dart';
part 'enrollment_state.dart';


// class EnrollmentBloc extends Bloc<EnrollmentEvent, EnrollmentState> {
//   final GetEnrollments getEnrollments;

//   EnrollmentBloc({required this.getEnrollments}) : super(EnrollmentInitial()) {
//     on<FetchEnrollments>(_onFetchEnrollments);
//   }

//   Future<void> _onFetchEnrollments(
//     FetchEnrollments event,
//     Emitter<EnrollmentState> emit,
//   ) async {
//     emit(EnrollmentLoading());
//     try {
//       final enrollments = await getEnrollments();
//       emit(EnrollmentLoaded(enrollments));
//     } catch (e) {
//       emit(EnrollmentError(e.toString()));
//     }
//   }
// }

class EnrollmentBloc extends Bloc<EnrollmentEvent, EnrollmentState> {
  final GetEnrollments getEnrollments;
  final ProcessPayment processPayment;

  EnrollmentBloc({
    required this.getEnrollments,
    required this.processPayment,
  }) : super(EnrollmentInitial()) {
    on<FetchEnrollments>(_onFetchEnrollments);
    on<SubmitPayment>(_onSubmitPayment);
  }

  Future<void> _onFetchEnrollments(
    FetchEnrollments event,
    Emitter<EnrollmentState> emit,
  ) async {
    emit(EnrollmentLoading());
    try {
      final enrollments = await getEnrollments();
      emit(EnrollmentLoaded(enrollments));
    } catch (e) {
      emit(EnrollmentError(e.toString()));
    }
  }

  Future<void> _onSubmitPayment(
    SubmitPayment event,
    Emitter<EnrollmentState> emit,
  ) async {
    if (state is EnrollmentLoaded) {
      try {
        emit(EnrollmentLoading());
        await processPayment(event.enrollmentId, event.amount);
        final enrollments = await getEnrollments();
        emit(EnrollmentLoaded(enrollments));
        emit(PaymentSuccess('Payment submitted successfully'));
      } catch (e) {
        emit(EnrollmentError(e.toString()));
      }
    }
  }
}