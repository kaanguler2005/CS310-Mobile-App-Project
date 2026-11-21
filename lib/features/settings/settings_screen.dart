import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/theme/colors.dart';
import '../../shared/widgets/confirmation_dialog.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/section_title.dart';

/// S7 Settings (student and instructor)
///
/// Settings for the account, opened from the Profile screen: the password,
/// notifications, language, and deleting the account.
///
/// The three settings are kept with SharedPreferences, so they survive
/// closing the app. That is the local storage lecture's own example of what
/// SharedPreferences is for: small, non-sensitive settings.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool newQuestionAlert = true;
  bool gradedAlert = true;
  String language = 'English';

  bool showLanguages = false;

  bool askDelete = false;

  final List<String> languages = ['English', 'Türkçe'];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!mounted) {
      return;
    }
    setState(() {
      newQuestionAlert = prefs.getBool('newQuestionAlert') ?? true;
      gradedAlert = prefs.getBool('gradedAlert') ?? true;
      language = prefs.getString('language') ?? 'English';
    });
  }

  Future<void> _saveSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('newQuestionAlert', newQuestionAlert);
    await prefs.setBool('gradedAlert', gradedAlert);
    await prefs.setString('language', language);
  }

  Widget _linkRow({
    required String label,
    required void Function() onTap,
    bool danger = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.fieldFill,
          border: Border.all(color: danger ? AppColors.error : AppColors.fieldBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  color: danger ? AppColors.error : AppColors.text,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: danger ? AppColors.error : AppColors.mutedText,
            ),
          ],
        ),
      ),
    );
  }

  Widget _switchRow({
    required String label,
    required bool value,
    required void Function(bool newValue) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 4),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        border: Border.all(color: AppColors.fieldBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 15, color: AppColors.text),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _languageBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              showLanguages = !showLanguages;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              border: Border.all(color: AppColors.fieldBorder),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    language,
                    style: const TextStyle(fontSize: 15, color: AppColors.text),
                  ),
                ),
                Icon(
                  showLanguages ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.mutedText,
                ),
              ],
            ),
          ),
        ),
        showLanguages
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: languages.map((String name) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        language = name;
                        showLanguages = false;
                      });
                      _saveSettings();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(left: 12, bottom: 6),
                      child: Row(
                        children: [
                          Icon(
                            name == language
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: name == language
                                ? AppColors.primary
                                : AppColors.mutedText,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            : const SizedBox(width: 0, height: 0),
      ],
    );
  }

  Widget _content() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle(text: 'ACCOUNT'),
        _linkRow(
          label: 'Change password',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Goes to S3 New password.')),
            );
          },
        ),

        const SectionTitle(text: 'NOTIFICATIONS'),
        _switchRow(
          label: 'A new question in my course',
          value: newQuestionAlert,
          onChanged: (bool newValue) {
            setState(() {
              newQuestionAlert = newValue;
            });
            _saveSettings();
          },
        ),
        _switchRow(
          label: 'My answer was graded',
          value: gradedAlert,
          onChanged: (bool newValue) {
            setState(() {
              gradedAlert = newValue;
            });
            _saveSettings();
          },
        ),

        const SectionTitle(text: 'LANGUAGE'),
        _languageBox(),

        const SizedBox(height: 28),
        _linkRow(
          label: 'Delete account',
          danger: true,
          onTap: () {
            setState(() {
              askDelete = true;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(title: 'Settings'),
      body: Stack(
        children: [
          _content(),
          askDelete
              ? ConfirmationDialog(
                  title: 'Delete account',
                  message: 'This cannot be undone.',
                  confirmLabel: 'Delete',
                  onCancel: () {
                    setState(() {
                      askDelete = false;
                    });
                  },
                  onConfirm: () {
                    setState(() {
                      askDelete = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Account deleted. Goes back to S1.'),
                      ),
                    );
                  },
                )
              : const SizedBox(width: 0, height: 0),
        ],
      ),
    );
  }
}
