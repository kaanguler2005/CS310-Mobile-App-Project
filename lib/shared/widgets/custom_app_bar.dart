import 'package:flutter/material.dart';

/// The one app bar every screen after login uses: the screen title, then
/// the home and profile icons on the right.
///
/// This is a utility class with a static method, not a StatelessWidget,
/// because Scaffold's appBar argument has to receive an AppBar itself.
/// Static methods in utility classes are the pattern from the
/// "Utility Classes & Forms" lecture.
class CustomAppBar {
  static AppBar build({
    required String title,
    void Function()? onHome,
    void Function()? onProfile,
  }) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: onHome,
          icon: const Icon(Icons.home),
        ),
        IconButton(
          onPressed: onProfile,
          icon: const Icon(Icons.person),
        ),
      ],
    );
  }
}
