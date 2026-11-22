import 'package:flutter/material.dart';

import '../../app/theme/spacing.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({
    super.key,
    required this.title,
    required this.child,
    this.onHome,
    this.onProfile,
    this.showBack = true,
  });

  final String title;
  final Widget child;
  final VoidCallback? onHome;
  final VoidCallback? onProfile;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: showBack,
        actions: [
          if (onHome != null)
            IconButton(
              tooltip: 'Home',
              onPressed: onHome,
              icon: const Icon(Icons.home_outlined),
            ),
          if (onProfile != null)
            IconButton(
              tooltip: 'Profile',
              onPressed: onProfile,
              icon: const Icon(Icons.person_outline),
            ),
        ],
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: child,
          ),
        ),
      ),
    );
  }
}

class StudyForm extends StatelessWidget {
  const StudyForm({super.key, required this.formKey, required this.children});

  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.all(AppSpacing.large),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}
