import 'package:flutter/material.dart';

import '../../shared/models/question.dart';
import '../../app/theme/colors.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/section_title.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key, required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(title: 'Feedback'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${question.code}  ${question.title}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              border: Border.all(color: AppColors.fieldBorder),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  '${question.grade} / 100',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'graded by ${question.gradedBy}',
                  style: const TextStyle(fontSize: 13, color: AppColors.mutedText),
                ),
              ],
            ),
          ),

          const SectionTitle(text: 'INSTRUCTOR COMMENTS'),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              border: Border.all(color: AppColors.fieldBorder),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              question.comments,
              style: const TextStyle(fontSize: 15, color: AppColors.text),
            ),
          ),

          const SectionTitle(text: 'YOUR ANSWER'),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              border: Border.all(color: AppColors.fieldBorder),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              question.myAnswer,
              style: const TextStyle(fontSize: 15, color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }
}
