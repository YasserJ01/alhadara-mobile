// onboarding_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_events.dart';
import 'onboarding_states.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  static const String _onboardingKey = 'has_completed_onboarding';
  final SharedPreferences prefs;

  OnboardingBloc({required this.prefs}) : super(OnboardingInitial()) {
    on<CheckOnboardingStatusEvent>(_checkOnboardingStatus);
    on<UpdateOnboardingPageEvent>(_updateOnboardingPage);
    on<CompleteOnboardingEvent>(_completeOnboarding);
  }

  Future<void> _checkOnboardingStatus(
      CheckOnboardingStatusEvent event,
      Emitter<OnboardingState> emit,
      ) async {
    emit(OnboardingLoading());
    try {
      final hasCompleted = prefs.getBool(_onboardingKey) ?? false;
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate loading
      emit(hasCompleted ? OnboardingCompleted() : OnboardingInProgress(pageIndex: 0));
    } catch (e) {
      emit(OnboardingError('Failed to check onboarding status: $e'));
    }
  }

  void _updateOnboardingPage(
      UpdateOnboardingPageEvent event,
      Emitter<OnboardingState> emit,
      ) {
    if (state is OnboardingInProgress) {
      emit(OnboardingInProgress(pageIndex: event.pageIndex));
    }
  }

  Future<void> _completeOnboarding(
      CompleteOnboardingEvent event,
      Emitter<OnboardingState> emit,
      ) async {
    try {
      await prefs.setBool(_onboardingKey, true);
      emit(OnboardingCompleted());
    } catch (e) {
      emit(OnboardingError('Failed to complete onboarding: $e'));
    }
  }

  // For testing/debug purposes
  Future<void> resetOnboarding() async {
    await prefs.remove(_onboardingKey);
    add(CheckOnboardingStatusEvent());
  }
}