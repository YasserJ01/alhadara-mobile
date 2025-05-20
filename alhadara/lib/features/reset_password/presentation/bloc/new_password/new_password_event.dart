abstract class ResetPasswordEvent {}

class PasswordsSubmitted extends ResetPasswordEvent {
  final String resetToken;
  final String newPassword;
  final String confirmPassword;

  PasswordsSubmitted({
    required this.resetToken,
    required this.newPassword,
    required this.confirmPassword,
  });
}