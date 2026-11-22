import 'package:flutter/material.dart';

import '../../../app/theme/spacing.dart';
import '../../../shared/widgets/my_text_field.dart';
import '../../../shared/widgets/study_page.dart';
import '../viewmodels/login_view_model.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({
    super.key,
    required this.viewModel,
    required this.onDemoLinkOpened,
  });

  final LoginViewModel viewModel;
  final ValueChanged<String> onDemoLinkOpened;

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _sendLink() async {
    if (!_form.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final email = widget.viewModel.normalizeEmail(_email.text);
    final canOpenDemoLink = widget.viewModel.hasDemoAccount(email);
    final openDemo = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Check your email'),
        content: Text(
          canOpenDemoLink
              ? 'Open the demo link to preview resetting your password.'
              : 'Email delivery is simulated in this preview. '
                    'Use a demo account email to open the reset link.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('OK'),
          ),
          if (canOpenDemoLink)
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Open demo link'),
            ),
        ],
      ),
    );
    if (!mounted || openDemo == null) return;
    if (openDemo) {
      widget.onDemoLinkOpened(email);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StudyPage(
      title: 'Forgot password',
      child: StudyForm(
        formKey: _form,
        children: [
          const Text(
            'Type the email on your account. We will send you a link '
            'to make a new password.',
          ),
          const SizedBox(height: AppSpacing.large),
          MyTextField(
            label: 'Email',
            hint: 'name@sabanciuniv.edu',
            controller: _email,
            validator: widget.viewModel.validateEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _sendLink(),
          ),
          const SizedBox(height: AppSpacing.large),
          FilledButton(
            onPressed: _sendLink,
            child: const Text('Send the link'),
          ),
        ],
      ),
    );
  }
}
