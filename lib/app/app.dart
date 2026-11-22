import 'package:flutter/material.dart';

import '../data/models/instructor_course.dart';
import '../data/models/study_profile.dart';
import '../features/auth/viewmodels/login_view_model.dart';
import '../features/auth/views/forgot_password_view.dart';
import '../features/auth/views/login_view.dart';
import '../features/auth/views/new_password_view.dart';
import '../features/instructor/viewmodels/instructor_view_model.dart';
import '../features/instructor/views/instructor_course_view.dart';
import '../features/instructor/views/instructor_home_view.dart';
import '../features/instructor/views/new_course_view.dart';
import '../features/instructor/views/new_question_view.dart';
import '../features/profile/views/profile_view.dart';
import 'theme/styles.dart';

class StudyTrackApp extends StatefulWidget {
  const StudyTrackApp({super.key});

  @override
  State<StudyTrackApp> createState() => _StudyTrackAppState();
}

class _StudyTrackAppState extends State<StudyTrackApp> {
  static const _instructorHome = '/instructor';

  final _navigator = GlobalKey<NavigatorState>();
  final _auth = LoginViewModel();
  final _instructor = InstructorViewModel();
  int _loginGeneration = 0;

  @override
  void dispose() {
    _auth.dispose();
    _instructor.dispose();
    super.dispose();
  }

  void _open(Widget screen, {String? routeName}) {
    _navigator.currentState!.push<void>(
      MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => screen,
      ),
    );
  }

  void _returnHome() {
    _navigator.currentState!.popUntil(
      (route) => route.settings.name == _instructorHome || route.isFirst,
    );
  }

  void _returnToLogin() {
    _auth.signOut();
    setState(() => _loginGeneration++);
    _navigator.currentState!.popUntil((route) => route.isFirst);
  }

  void _openHome(BuildContext context) {
    final profile = _auth.activeProfile;
    if (profile?.role != StudyRole.instructor) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student home is not available in this preview.'),
        ),
      );
      return;
    }
    _open(
      InstructorHomeView(
        auth: _auth,
        viewModel: _instructor,
        onHome: _returnHome,
        onProfile: _openProfile,
        onNewCourse: _openNewCourse,
        onOpenCourse: _openCourse,
      ),
      routeName: _instructorHome,
    );
  }

  void _openProfile() {
    _open(
      ProfileView(
        viewModel: _auth,
        onHome: _returnHome,
        onLogOut: _returnToLogin,
      ),
    );
  }

  void _openNewCourse() {
    _open(
      NewCourseView(
        viewModel: _instructor,
        onHome: _returnHome,
        onProfile: _openProfile,
      ),
    );
  }

  void _openCourse(InstructorCourse course) {
    _open(
      InstructorCourseView(
        viewModel: _instructor,
        joinCode: course.joinCode,
        onHome: _returnHome,
        onProfile: _openProfile,
        onNewQuestion: () => _open(
          NewQuestionView(
            viewModel: _instructor,
            joinCode: course.joinCode,
            onHome: _returnHome,
            onProfile: _openProfile,
          ),
        ),
      ),
    );
  }

  void _openForgotPassword() {
    _open(
      ForgotPasswordView(
        viewModel: _auth,
        onDemoLinkOpened: (email) => _open(
          NewPasswordView(
            onSave: (password) => _auth.resetDemoPassword(email, password),
            onComplete: _returnToLogin,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigator,
      title: 'StudyTrack',
      debugShowCheckedModeBanner: false,
      theme: buildStudyTrackTheme(),
      home: Builder(
        builder: (context) => LoginView(
          key: ValueKey(_loginGeneration),
          viewModel: _auth,
          onSignedIn: () => _openHome(context),
          onForgotPassword: _openForgotPassword,
        ),
      ),
    );
  }
}
