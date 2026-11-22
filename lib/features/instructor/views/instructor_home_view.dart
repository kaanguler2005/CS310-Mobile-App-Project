import 'package:flutter/material.dart';

import '../../../app/theme/spacing.dart';
import '../../../data/models/instructor_course.dart';
import '../../../shared/widgets/profile_photo.dart';
import '../../../shared/widgets/study_page.dart';
import '../../auth/viewmodels/login_view_model.dart';
import '../viewmodels/instructor_view_model.dart';

class InstructorHomeView extends StatelessWidget {
  const InstructorHomeView({
    super.key,
    required this.auth,
    required this.viewModel,
    required this.onHome,
    required this.onProfile,
    required this.onNewCourse,
    required this.onOpenCourse,
  });

  final LoginViewModel auth;
  final InstructorViewModel viewModel;
  final VoidCallback onHome;
  final VoidCallback onProfile;
  final VoidCallback onNewCourse;
  final ValueChanged<InstructorCourse> onOpenCourse;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StudyPage(
      title: 'My courses',
      showBack: false,
      onHome: onHome,
      onProfile: onProfile,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListenableBuilder(
              listenable: Listenable.merge([auth, viewModel]),
              builder: (context, child) {
                final profile = auth.activeProfile;
                if (profile == null) return const SizedBox.shrink();
                return ListView(
                  padding: const EdgeInsets.all(AppSpacing.large),
                  children: [
                    Row(
                      children: [
                        ProfilePhoto(url: profile.photoUrl),
                        const SizedBox(width: AppSpacing.medium),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, ${profile.displayName}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(profile.role.label),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.large),
                    for (final course in viewModel.courses)
                      Card.outlined(
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                          title: Text(
                            course.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Code: ${course.joinCode}\n'
                            '${course.studentCount} students, '
                            '${course.questions.length} questions',
                          ),
                          onTap: () => onOpenCourse(course),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.large),
            child: FilledButton(
              onPressed: onNewCourse,
              child: const Text('Create a new course'),
            ),
          ),
        ],
      ),
    );
  }
}
