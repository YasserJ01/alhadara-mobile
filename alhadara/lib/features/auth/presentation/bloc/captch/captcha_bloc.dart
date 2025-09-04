// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import '../../../data/datasources/auth_remote_data_source.dart';
// import '../../../data/models/captcha_response_model.dart';

// part 'captcha_event.dart';
// part 'captcha_state.dart';

// class CaptchaBloc extends Bloc<CaptchaEvent, CaptchaState> {
//   final AuthRemoteDataSource remoteDataSource;

//   CaptchaBloc({required this.remoteDataSource}) : super(CaptchaInitial()) {
//     on<LoadCaptcha>(_onLoadCaptcha);
//     on<RefreshCaptcha>(_onRefreshCaptcha);
//     on<VerifyCaptcha>(_onVerifyCaptcha); // أضف معالج الحدث الجديد
//   }

//   Future<void> _onLoadCaptcha(
//     LoadCaptcha event,
//     Emitter<CaptchaState> emit,
//   ) async {
//     emit(CaptchaLoading());
//     try {
//       final captcha = await remoteDataSource.getCaptcha();
//       emit(CaptchaLoaded(captcha: captcha));
//     } catch (e) {
//       emit(CaptchaError(error: e.toString()));
//     }
//   }

//   Future<void> _onRefreshCaptcha(
//     RefreshCaptcha event,
//     Emitter<CaptchaState> emit,
//   ) async {
//     emit(CaptchaLoading());
//     try {
//       final captcha = await remoteDataSource.getCaptcha();
//       emit(CaptchaLoaded(captcha: captcha));
//     } catch (e) {
//       emit(CaptchaError(error: e.toString()));
//     }
//   }

//   // أضف معالج التحقق من CAPTCHA
//   Future<void> _onVerifyCaptcha(
//     VerifyCaptcha event,
//     Emitter<CaptchaState> emit,
//   ) async {
//     emit(CaptchaLoading());
//     try {
//       final isValid = await remoteDataSource.verifyCaptcha(event.key, event.answer);
//       emit(CaptchaVerified(isValid: isValid));
      
//       // إذا كان غير صالح، نعود إلى الحالة المحملة
//       if (!isValid) {
//         final captcha = await remoteDataSource.getCaptcha();
//         emit(CaptchaLoaded(captcha: captcha));
//       }
//     } catch (e) {
//       emit(CaptchaError(error: e.toString()));
//     }
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/datasources/auth_remote_data_source.dart';
import '../../../data/models/captcha_response_model.dart';

part 'captcha_event.dart';
part 'captcha_state.dart';

class CaptchaBloc extends Bloc<CaptchaEvent, CaptchaState> {
  final AuthRemoteDataSource remoteDataSource;

  CaptchaBloc({required this.remoteDataSource}) : super(CaptchaInitial()) {
    on<LoadCaptcha>(_onLoadCaptcha);
    on<RefreshCaptcha>(_onRefreshCaptcha);
    on<VerifyCaptcha>(_onVerifyCaptcha);
  }

  Future<void> _onLoadCaptcha(
    LoadCaptcha event,
    Emitter<CaptchaState> emit,
  ) async {
    emit(CaptchaLoading());
    try {
      final captcha = await remoteDataSource.getCaptcha();
      emit(CaptchaLoaded(captcha: captcha));
    } catch (e) {
      emit(CaptchaError(error: e.toString()));
    }
  }

  Future<void> _onRefreshCaptcha(
    RefreshCaptcha event,
    Emitter<CaptchaState> emit,
  ) async {
    emit(CaptchaLoading());
    try {
      final captcha = await remoteDataSource.getCaptcha();
      emit(CaptchaLoaded(captcha: captcha));
    } catch (e) {
      emit(CaptchaError(error: e.toString()));
    }
  }

 Future<void> _onVerifyCaptcha(
  VerifyCaptcha event,
  Emitter<CaptchaState> emit,
) async {
  emit(CaptchaLoading());
  try {
    final isValid = await remoteDataSource.verifyCaptcha(event.key, event.answer);

    if (isValid) {
      emit(CaptchaVerified(isValid: true));
    } else {
      emit(CaptchaError(error: "CAPTCHA code is incorrect. Please try again."));
    }
  } catch (e) {
    emit(CaptchaError(error: "Server error while verifying CAPTCHA. Please try later."));
  }
}

}