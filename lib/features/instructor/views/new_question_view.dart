import 'package:flutter/material.dart';

import '../../../app/theme/spacing.dart';
import '../../../shared/widgets/my_text_field.dart';
import '../../../shared/widgets/study_page.dart';
import '../viewmodels/instructor_view_model.dart';

enum _Audience { all, selected }

class NewQuestionView extends StatefulWidget {
  const NewQuestionView({
    super.key,
    required this.viewModel,
    required this.joinCode,
    required this.onHome,
    required this.onProfile,
  });

  final InstructorViewModel viewModel;
  final String joinCode;
  final VoidCallback onHome;
  final VoidCallback onProfile;

  @override
  State<NewQuestionView> createState() => _NewQuestionViewState();
}

class _NewQuestionViewState extends State<NewQuestionView> {
  final _form = GlobalKey<FormState>();
  final _topic = TextEditingController();
  final _question = TextEditingController();
  final _selectedStudents = <int>{};
  _Audience _audience = _Audience.all;
  String? _audienceError;

  @override
  void dispose() {
    _topic.dispose();
    _question.dispose();
    super.dispose();
  }

  void _send() {
    final validPrompt = _form.currentState!.validate();
    final missingStudents =
        _audience == _Audience.selected && _selectedStudents.isEmpty;
    setState(() {
      _audienceError = missingStudents ? 'Select at least one student.' : null;
    });
    if (!validPrompt || missingStudents) return;

    widget.viewModel.addQuestion(
      widget.joinCode,
      topic: _topic.text,
      prompt: _question.text,
      recipients: _audience == _Audience.all ? null : _selectedStudents,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final studentCount = widget.viewModel
        .courseFor(widget.joinCode)
        .studentCount;
    final audienceError = _audienceError;

    return StudyPage(
      title: 'New question',
      onHome: widget.onHome,
      onProfile: widget.onProfile,
      child: StudyForm(
        formKey: _form,
        children: [
          MyTextField(
            label: 'Topic',
            hint: 'Widgets',
            controller: _topic,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.medium),
          MyTextField(
            label: 'Question',
            hint:
                'What is the difference between a StatelessWidget and '
                'a StatefulWidget?',
            controller: _question,
            validator: (value) =>
                (value ?? '').trim().isEmpty ? 'Enter a question.' : null,
            maxLines: 4,
          ),
          const SizedBox(height: AppSpacing.large),
          Text('WHO GETS THIS QUESTION?', style: theme.textTheme.labelMedium),
          RadioGroup<_Audience>(
            groupValue: _audience,
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _audience = value;
                _audienceError = null;
              });
            },
            child: Column(
              children: [
                const RadioListTile<_Audience>(
                  value: _Audience.all,
                  title: Text('All students in the course'),
                  contentPadding: EdgeInsets.zero,
                ),
                RadioListTile<_Audience>(
                  value: _Audience.selected,
                  enabled: studentCount != 0,
                  title: const Text('Only the students I pick'),
                  subtitle: studentCount == 0
                      ? const Text('No students have joined yet.')
                      : null,
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          if (_audience == _Audience.selected)
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 240),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: studentCount,
                itemBuilder: (context, index) {
                  final number = index + 1;
                  return CheckboxListTile(
                    title: Text('Student $number'),
                    value: _selectedStudents.contains(number),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (checked) {
                      setState(() {
                        if (checked == true) {
                          _selectedStudents.add(number);
                        } else {
                          _selectedStudents.remove(number);
                        }
                        _audienceError = null;
                      });
                    },
                  );
                },
              ),
            ),
          if (audienceError != null)
            Text(
              audienceError,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          const SizedBox(height: AppSpacing.large),
          FilledButton(onPressed: _send, child: const Text('Send to students')),
        ],
      ),
    );
  }
}
