import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  String? _passwordError;

  String? get passwordError => _passwordError;

  String? validateEmail(String? value) {
    final email = (value ?? '').trim();
    if (email.isEmpty) return 'Enter your email.';
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    return value == null || value.isEmpty ? 'Enter your password.' : null;
  }

  bool signIn(String email, String password) {
    final matchesDemoAccount =
        email.trim().toLowerCase() == 'student@example.com' &&
        password == 'StudyTrack123';
    _passwordError = matchesDemoAccount
        ? null
        : 'Wrong email or password. Try again.';
    notifyListeners();
    return matchesDemoAccount;
  }

  void clearPasswordError() {
    if (_passwordError == null) return;
    _passwordError = null;
    notifyListeners();
  }
}
