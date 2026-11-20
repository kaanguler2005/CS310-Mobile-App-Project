import 'package:flutter/material.dart';

import '../features/auth/views/login_view.dart';
import 'theme/styles.dart';

class StudyTrackApp extends StatelessWidget {
  const StudyTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyTrack',
      debugShowCheckedModeBanner: false,
      theme: buildStudyTrackTheme(),
      home: const LoginView(),
    );
  }
}
