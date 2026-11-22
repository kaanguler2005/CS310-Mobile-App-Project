import 'package:flutter/material.dart';

import '../../../app/theme/spacing.dart';
import '../../../shared/widgets/my_text_field.dart';
import '../../../shared/widgets/study_page.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({
    super.key,
    required this.onSave,
    required this.onComplete,
  });

  final ValueChanged<String> onSave;
  final VoidCallback onComplete;

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  final _form = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _repeat = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    _repeat.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    widget.onSave(_password.text);
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Password changed'),
        content: const Text('You can log in with it now.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (mounted) widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return StudyPage(
      title: 'New password',
      child: StudyForm(
        formKey: _form,
        children: [
          const Text(
            'Type a new password twice so we know it is the one you want.',
          ),
          const SizedBox(height: AppSpacing.large),
          MyTextField(
            label: 'New password',
            hint: 'at least 8 characters',
            controller: _password,
            validator: (value) =>
                (value ?? '').length < 8 ? 'Use at least 8 characters.' : null,
            obscureText: true,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.medium),
          MyTextField(
            label: 'Repeat new password',
            hint: 'type it again',
            controller: _repeat,
            validator: (value) => value == null || value.isEmpty
                ? 'Repeat your new password.'
                : value != _password.text
                ? 'The two passwords are not the same.'
                : null,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _save(),
          ),
          const SizedBox(height: AppSpacing.large),
          FilledButton(onPressed: _save, child: const Text('Save')),
        ],
      ),
    );
  }
}
