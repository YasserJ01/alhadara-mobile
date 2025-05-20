class Validators {
  static String? validateSyrianPhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';

    final regex = RegExp(r'^(\+9639\d{8}|09\d{8})$');
    if (!regex.hasMatch(value)) {
      return 'Enter valid Syrian number (+9639... or 09...)';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty)
      return null; // Don't show error when empty

    final errors = <String>[];
    if (value.length < 8) errors.add('8+ characters');
    if (!value.contains(RegExp(r'[A-Z]'))) errors.add('1 uppercase letter');
    if (!value.contains(RegExp(r'[0-9]'))) errors.add('1 number');
    if (!value.contains(RegExp('(?=.*?[!@#\$&*~])')))
      errors.add('1 special character');
    return errors.isEmpty ? null : 'Requires: ${errors.join(', ')}';
  }
}
