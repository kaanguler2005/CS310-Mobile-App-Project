import 'package:flutter/material.dart';

import '../../../app/theme/spacing.dart';
import '../../../shared/widgets/my_text_field.dart';
import '../../../shared/widgets/study_page.dart';
import '../viewmodels/instructor_view_model.dart';

class NewCourseView extends StatefulWidget {
  const NewCourseView({
    super.key,
    required this.viewModel,
    required this.onHome,
    required this.onProfile,
  });

  final InstructorViewModel viewModel;
  final VoidCallback onHome;
  final VoidCallback onProfile;

  @override
  State<NewCourseView> createState() => _NewCourseViewState();
}

class _NewCourseViewState extends State<NewCourseView> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    if (!_form.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final course = widget.viewModel.createCourse(
      _title.text,
      _description.text,
    );
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Course created'),
        content: Text(
          'Join code: ${course.joinCode}. Give this code to your students.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return StudyPage(
      title: 'New course',
      onHome: widget.onHome,
      onProfile: widget.onProfile,
      child: StudyForm(
        formKey: _form,
        children: [
          MyTextField(
            label: 'Course title',
            hint: 'CS310 Mobile App Dev',
            controller: _title,
            validator: (value) =>
                (value ?? '').trim().isEmpty ? 'Enter a course title.' : null,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.medium),
          MyTextField(
            label: 'Short description',
            hint: 'Flutter and Dart basics and a team project.',
            controller: _description,
            maxLines: 4,
          ),
          const SizedBox(height: AppSpacing.large),
          FilledButton(onPressed: _create, child: const Text('Create')),
        ],
      ),
    );
  }
}
