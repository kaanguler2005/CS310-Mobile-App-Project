import 'package:flutter/foundation.dart';

import '../../../data/models/study_profile.dart';

class LoginViewModel extends ChangeNotifier {
  static const _demoPhoto =
      'https://placehold.co/192x192/E6E7FA/5242D4/png?text=Photo';

  final _accounts = <String, StudyProfile>{
    'student@example.com': const StudyProfile(
      displayName: 'Student 1',
      email: 'student@example.com',
      role: StudyRole.student,
      photoUrl: _demoPhoto,
    ),
    'instructor@example.com': const StudyProfile(
      displayName: 'Instructor 1',
      email: 'instructor@example.com',
      role: StudyRole.instructor,
      photoUrl: _demoPhoto,
    ),
  };

  final _passwords = {
    'student@example.com': 'StudyTrack123',
    'instructor@example.com': 'StudyTrack123',
  };

  String? _signedInEmail;
  String? _passwordError;

  String? get passwordError => _passwordError;
  StudyProfile? get activeProfile => _accounts[_signedInEmail];

  String normalizeEmail(String email) => email.trim().toLowerCase();

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
    final normalized = normalizeEmail(email);
    final matched = _passwords[normalized] == password;
    _signedInEmail = matched ? normalized : null;
    _passwordError = matched ? null : 'Wrong email or password. Try again.';
    notifyListeners();
    return matched;
  }

  bool hasDemoAccount(String email) =>
      _accounts.containsKey(normalizeEmail(email));

  void resetDemoPassword(String email, String password) {
    final normalized = normalizeEmail(email);
    if (!_accounts.containsKey(normalized)) return;
    _passwords[normalized] = password;
    clearPasswordError();
  }

  void updateActiveProfile(String name, String photoUrl) {
    final profile = activeProfile;
    if (profile == null) return;
    _accounts[profile.email] = StudyProfile(
      displayName: name.trim(),
      email: profile.email,
      role: profile.role,
      photoUrl: photoUrl.trim(),
    );
    notifyListeners();
  }

  void signOut() {
    _signedInEmail = null;
    _passwordError = null;
    notifyListeners();
  }

  void clearPasswordError() {
    if (_passwordError == null) return;
    _passwordError = null;
    notifyListeners();
  }
}
