abstract class RequestSecurityQuestionEvent {}

class PhoneNumberSubmitted extends RequestSecurityQuestionEvent {
  final String phoneNumber;
  PhoneNumberSubmitted({required this.phoneNumber});
}