import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';

/// The small grey heading above a group of content: ACCOUNT,
/// NOTIFICATIONS, QUESTIONS, INSTRUCTOR COMMENTS, YOUR ANSWER.
///
/// Reusable StatelessWidget with required named inputs, the pattern from
/// the ProfileCard example in the Stateless Widgets lecture.
class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.mutedText,
        ),
      ),
    );
  }
}
