import 'package:flutter/material.dart';

import '../../shared/models/student_answer.dart';
import '../../app/theme/colors.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/section_title.dart';

class GiveGradeScreen extends StatefulWidget {
  const GiveGradeScreen({
    super.key,
    required this.questionCode,
    required this.questionText,
    required this.answer,
    required this.onSaved,
  });

  final String questionCode;
  final String questionText;
  final StudentAnswer answer;
  final void Function(String grade, String comments) onSaved;

  @override
  State<GiveGradeScreen> createState() => _GiveGradeScreenState();
}

class _GiveGradeScreenState extends State<GiveGradeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _grade = '';
  String _comments = '';

  String? _validateGrade(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'A grade is required';
    }
    final RegExp zeroToHundred = RegExp(r'^(100|[1-9]?[0-9])$');
    if (!zeroToHundred.hasMatch(value.trim())) {
      return 'Write a number between 0 and 100';
    }
    return null;
  }

  String? _validateComments(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Write a short comment for the student';
    }
    return null;
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      widget.onSaved(_grade, _comments);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('The grade was saved.')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(title: 'Give a grade'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SectionTitle(
              text: '${widget.answer.studentName.toUpperCase()}  '
                  '${widget.questionCode}',
            ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                border: Border.all(color: AppColors.fieldBorder),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.questionText,
                style: const TextStyle(fontSize: 15, color: AppColors.text),
              ),
            ),

            const SectionTitle(text: 'THE ANSWER'),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                border: Border.all(color: AppColors.fieldBorder),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.answer.answerText,
                style: const TextStyle(fontSize: 15, color: AppColors.text),
              ),
            ),

            const SectionTitle(text: 'GRADE OUT OF 100'),
            TextFormField(
              initialValue: widget.answer.grade,
              decoration: const InputDecoration(
                hintText: '0 - 100',
              ),
              validator: _validateGrade,
              onSaved: (String? value) {
                _grade = value == null ? '' : value.trim();
              },
            ),

            const SectionTitle(text: 'COMMENTS'),
            TextFormField(
              initialValue: widget.answer.comments,
              decoration: const InputDecoration(
                hintText: 'What was good, what to add next time',
              ),
              validator: _validateComments,
              onSaved: (String? value) {
                _comments = value == null ? '' : value.trim();
              },
            ),

            const SizedBox(height: 24),
            FilledButton(
              onPressed: _save,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
