import 'package:flutter/material.dart';

import '../../../app/theme/spacing.dart';
import '../../../shared/widgets/my_text_field.dart';
import '../viewmodels/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
    this.viewModel,
    this.onSignedIn,
    this.onForgotPassword,
    this.onSignUp,
  });

  final LoginViewModel? viewModel;
  final VoidCallback? onSignedIn;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onSignUp;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  late final _localViewModel = LoginViewModel();
  LoginViewModel get _viewModel => widget.viewModel ?? _localViewModel;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    if (widget.viewModel == null) _localViewModel.dispose();
    super.dispose();
  }

  void _signIn() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    if (!_viewModel.signIn(_email.text, _password.text)) return;

    final onSignedIn = widget.onSignedIn;
    if (onSignedIn != null) {
      onSignedIn();
    } else {
      _showMessage('Demo login successful.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mutedStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.large,
              vertical: AppSpacing.extraLarge,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: AutofillGroup(
                onDisposeAction: AutofillContextAction.cancel,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/logo_placeholder.png',
                          width: 88,
                          height: 88,
                          excludeFromSemantics: true,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.medium),
                      Text(
                        'StudyTrack',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.small),
                      Text(
                        'Study. Submit. Improve.',
                        textAlign: TextAlign.center,
                        style: mutedStyle,
                      ),
                      const SizedBox(height: AppSpacing.large),
                      MyTextField(
                        label: 'Email',
                        hint: 'name@sabanciuniv.edu',
                        controller: _email,
                        validator: _viewModel.validateEmail,
                        onChanged: (_) => _viewModel.clearPasswordError(),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.username],
                      ),
                      const SizedBox(height: AppSpacing.small),
                      ListenableBuilder(
                        listenable: _viewModel,
                        builder: (context, child) {
                          return MyTextField(
                            label: 'Password',
                            hint: 'your password',
                            controller: _password,
                            validator: _viewModel.validatePassword,
                            onChanged: (_) => _viewModel.clearPasswordError(),
                            onFieldSubmitted: (_) => _signIn(),
                            errorText: _viewModel.passwordError,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.password],
                            obscureText: true,
                          );
                        },
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsetsDirectional.only(
                              end: AppSpacing.medium,
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed:
                              widget.onForgotPassword ??
                              () => _showMessage(
                                'Password reset is not available in this preview.',
                              ),
                          child: const Text('Forgot password?'),
                        ),
                      ),
                      FilledButton(
                        onPressed: _signIn,
                        child: const Text('Log in'),
                      ),
                      const SizedBox(height: AppSpacing.medium),
                      Text(
                        'Do not have an account yet?',
                        textAlign: TextAlign.center,
                        style: mutedStyle,
                      ),
                      const SizedBox(height: AppSpacing.small),
                      OutlinedButton(
                        onPressed:
                            widget.onSignUp ??
                            () => _showMessage(
                              'Sign up is not available in this preview.',
                            ),
                        child: const Text('Sign up'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
