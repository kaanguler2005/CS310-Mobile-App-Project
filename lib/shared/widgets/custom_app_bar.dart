import 'package:flutter/material.dart';

import '../../app/app_nav.dart';

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
          onPressed: onHome ?? AppNav.goHome,
          icon: const Icon(Icons.home),
        ),
        IconButton(
          onPressed: onProfile ?? AppNav.openProfile,
          icon: const Icon(Icons.person),
        ),
      ],
    );
  }
}
