abstract class SplashState {
  const SplashState();
}

class SplashInitial extends SplashState {}
class SplashAnimationRunning extends SplashState {}
class ShowDotsAnimation extends SplashState {}
class SplashComplete extends SplashState {}