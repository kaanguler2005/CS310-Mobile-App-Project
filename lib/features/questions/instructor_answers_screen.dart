import 'package:flutter/material.dart';

import '../../shared/models/student_answer.dart';
import '../../app/theme/colors.dart';
import '../../shared/widgets/course_card.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/section_title.dart';
import 'give_grade_screen.dart';

/// S19 Answers (instructor)
///
/// Every answer that was sent for one question, each one marked graded or
/// not graded. Tapping an answer goes to S20.
class InstructorAnswersScreen extends StatefulWidget {
  const InstructorAnswersScreen({
    super.key,
    required this.questionCode,
    required this.questionTitle,
    required this.questionText,
    required this.answers,
  });

  final String questionCode;
  final String questionTitle;
  final String questionText;
  final List<StudentAnswer> answers;

  @override
  State<InstructorAnswersScreen> createState() =>
      _InstructorAnswersScreenState();
}

class _InstructorAnswersScreenState extends State<InstructorAnswersScreen> {
  void _openAnswer(StudentAnswer answer) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => GiveGradeScreen(
          questionCode: widget.questionCode,
          questionText: widget.questionText,
          answer: answer,
          onSaved: (String grade, String comments) {
            setState(() {
              answer.grade = grade;
              answer.comments = comments;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(title: 'Answers'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(text: widget.questionCode),
                Text(
                  widget.questionTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 16, right: 16),
              itemCount: widget.answers.length,
              itemBuilder: (BuildContext context, int index) {
                final StudentAnswer answer = widget.answers[index];
                return CourseCard(
                  title: answer.studentName,
                  subtitle: answer.sentAt,
                  trailing: answer.statusLabel(),
                  onTap: () {
                    _openAnswer(answer);
                  },
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Tap an answer to give it a grade.',
              style: TextStyle(fontSize: 13, color: AppColors.mutedText),
            ),
          ),
        ],
      ),
    );
  }
}
