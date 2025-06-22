abstract class OnboardingEvent {}

class CheckOnboardingStatusEvent extends OnboardingEvent {}

class UpdateOnboardingPageEvent extends OnboardingEvent {
  final int pageIndex;
  UpdateOnboardingPageEvent(this.pageIndex);
}

class CompleteOnboardingEvent extends OnboardingEvent {}
