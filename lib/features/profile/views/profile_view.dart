import 'package:flutter/material.dart';

import '../../../app/theme/spacing.dart';
import '../../../data/models/study_profile.dart';
import '../../../shared/widgets/my_text_field.dart';
import '../../../shared/widgets/profile_photo.dart';
import '../../../shared/widgets/study_page.dart';
import '../../auth/viewmodels/login_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
    required this.viewModel,
    required this.onHome,
    required this.onLogOut,
    this.onSettings,
  });

  final LoginViewModel viewModel;
  final VoidCallback onHome;
  final VoidCallback onLogOut;
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    return StudyPage(
      title: 'Profile',
      onHome: onHome,
      child: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          final profile = viewModel.activeProfile;
          if (profile == null) return const SizedBox.shrink();
          final theme = Theme.of(context);

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.large),
            children: [
              Center(child: ProfilePhoto(url: profile.photoUrl, radius: 40)),
              const SizedBox(height: AppSpacing.medium),
              Text(
                profile.displayName,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.small),
              Text(profile.email, textAlign: TextAlign.center),
              Text(profile.role.label, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.large),
              OutlinedButton(
                onPressed: onHome,
                child: const Text('My courses'),
              ),
              const SizedBox(height: AppSpacing.small),
              OutlinedButton(
                onPressed:
                    onSettings ??
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Settings is not available in this preview.',
                          ),
                        ),
                      );
                    },
                child: const Text('Settings'),
              ),
              const SizedBox(height: AppSpacing.small),
              OutlinedButton(
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (_) => _EditProfileDialog(
                    profile: profile,
                    onSave: viewModel.updateActiveProfile,
                  ),
                ),
                child: const Text('Edit profile'),
              ),
              const SizedBox(height: AppSpacing.small),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                  side: BorderSide(color: theme.colorScheme.error),
                ),
                onPressed: onLogOut,
                child: const Text('Log out'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EditProfileDialog extends StatefulWidget {
  const _EditProfileDialog({required this.profile, required this.onSave});

  final StudyProfile profile;
  final void Function(String name, String photoUrl) onSave;

  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.profile.displayName);
  late final _photo = TextEditingController(text: widget.profile.photoUrl);

  @override
  void dispose() {
    _name.dispose();
    _photo.dispose();
    super.dispose();
  }

  String? _validatePhoto(String? value) {
    final address = value?.trim() ?? '';
    if (address.isEmpty) return null;
    final uri = Uri.tryParse(address);
    if (uri == null ||
        uri.host.isEmpty ||
        (uri.scheme != 'https' && uri.scheme != 'http')) {
      return 'Enter a valid photo address.';
    }
    return null;
  }

  void _save() {
    if (!_form.currentState!.validate()) return;
    widget.onSave(_name.text, _photo.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit profile'),
      scrollable: true,
      content: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextField(
              label: 'Display name',
              hint: 'your name',
              controller: _name,
              validator: (text) =>
                  (text ?? '').trim().isEmpty ? 'Enter a display name.' : null,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppSpacing.medium),
            MyTextField(
              label: 'Photo address',
              hint: 'https://example.com/photo.jpg',
              controller: _photo,
              validator: _validatePhoto,
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _save(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }
}
