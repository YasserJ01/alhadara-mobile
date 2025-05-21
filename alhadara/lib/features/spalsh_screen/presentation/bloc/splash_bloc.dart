import 'package:bloc/bloc.dart';
import 'package:alhadara/features/spalsh_screen/presentation/bloc/splash_event.dart';
import 'package:alhadara/features/spalsh_screen/presentation/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>((event, emit) => emit(SplashAnimationRunning()));
    on<SplashAnimationComplete>((event, emit) => emit(ShowDotsAnimation()));
    on<DotsAnimationComplete>((event, emit) => emit(SplashComplete()));
  }
}