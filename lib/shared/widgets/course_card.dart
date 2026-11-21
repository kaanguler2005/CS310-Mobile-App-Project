import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';

/// One row in a list: a course on S5 and S15, a question on S9 and S17,
/// a student's answer on S19.
///
/// subtitle2 is for the screens that need two lines under the title
/// (S15 and S19). trailing is the grey text on the right (the question
/// state on S9, the grade on S19). Leave either empty to hide it.
///
/// The tap is a GestureDetector, the widget from the callbacks part of the
/// Dart Programming Basics lecture. onTap may be null, and then the card
/// simply does not react.
class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitle2 = '',
    this.trailing = '',
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String subtitle2;
  final String trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.mutedText,
                      ),
                    ),
                    subtitle2.isEmpty
                        ? const SizedBox(width: 0, height: 0)
                        : Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              subtitle2,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.mutedText,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Text(
                trailing,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.mutedText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
