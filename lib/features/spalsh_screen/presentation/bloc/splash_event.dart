abstract class SplashEvent {
  const SplashEvent();
}

class SplashStarted extends SplashEvent {}
class SplashAnimationComplete extends SplashEvent {}
class DotsAnimationComplete extends SplashEvent {}