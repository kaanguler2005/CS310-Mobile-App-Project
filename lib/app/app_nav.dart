import 'package:flutter/material.dart';

class AppNav {
  static VoidCallback? goHome;
  static VoidCallback? openProfile;
  static Future<void> Function(String courseCode, String courseName)?
      openStudentCourse;
}
