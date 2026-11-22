import 'package:flutter/material.dart';

import '../../../app/theme/spacing.dart';
import '../../../data/models/instructor_course.dart';
import '../../../shared/widgets/study_page.dart';
import '../viewmodels/instructor_view_model.dart';

class InstructorCourseView extends StatelessWidget {
  const InstructorCourseView({
    super.key,
    required this.viewModel,
    required this.joinCode,
    required this.onHome,
    required this.onProfile,
    required this.onNewQuestion,
    this.onAnswers,
  });

  final InstructorViewModel viewModel;
  final String joinCode;
  final VoidCallback onHome;
  final VoidCallback onProfile;
  final VoidCallback onNewQuestion;
  final ValueChanged<InstructorQuestion>? onAnswers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        final course = viewModel.courseFor(joinCode);
        return StudyPage(
          title: course.title,
          onHome: onHome,
          onProfile: onProfile,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.large),
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppSpacing.controlRadius),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.medium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('JOIN CODE', style: theme.textTheme.labelMedium),
                      const SizedBox(height: AppSpacing.small),
                      Wrap(
                        spacing: AppSpacing.medium,
                        runSpacing: AppSpacing.small,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SelectableText(
                            course.joinCode,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('${course.studentCount} students'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.large),
              Text('QUESTIONS', style: theme.textTheme.labelMedium),
              const SizedBox(height: AppSpacing.small),
              if (course.questions.isEmpty) const Text('No questions yet.'),
              for (final (index, question) in course.questions.indexed)
                Card.outlined(
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    title: Text(
                      'Q${index + 1} ${question.title}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      [
                        if (question.topic.isNotEmpty) question.topic,
                        question.audienceLabel,
                      ].join(', '),
                    ),
                    onTap: () {
                      final openAnswers = onAnswers;
                      if (openAnswers != null) {
                        openAnswers(question);
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Answers are not available in this preview.',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: AppSpacing.medium),
              FilledButton(
                onPressed: onNewQuestion,
                child: const Text('Add a question'),
              ),
            ],
          ),
        );
      },
    );
  }
}
