import 'package:flutter/material.dart';

import '../../shared/models/question.dart';
import '../../app/theme/colors.dart';
import '../../shared/widgets/course_card.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/section_title.dart';
import 'answer_question_screen.dart';
import 'feedback_screen.dart';

class StudentCourseScreen extends StatefulWidget {
  const StudentCourseScreen({
    super.key,
    required this.courseTitle,
    required this.instructorName,
    required this.studentCount,
    required this.questions,
  });

  final String courseTitle;
  final String instructorName;
  final int studentCount;
  final List<Question> questions;

  @override
  State<StudentCourseScreen> createState() => _StudentCourseScreenState();
}

class _StudentCourseScreenState extends State<StudentCourseScreen> {
  void _openQuestion(Question question) {
    if (question.status == 'Graded') {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => FeedbackScreen(question: question),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => AnswerQuestionScreen(
          question: question,
          readOnly: question.status == 'Sent',
          onSubmit: (String answer) {
            setState(() {
              question.myAnswer = answer;
              question.status = 'Sent';
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(title: widget.courseTitle),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(text: 'INSTRUCTOR'),
          Text(
            '${widget.instructorName}, ${widget.studentCount} students',
            style: const TextStyle(fontSize: 15, color: AppColors.text),
          ),
          const SectionTitle(text: 'QUESTIONS'),

          ...widget.questions.map((Question question) {
            return CourseCard(
              title: '${question.code}  ${question.title}',
              subtitle: 'Topic: ${question.topic}',
              trailing: question.status,
              onTap: () {
                _openQuestion(question);
              },
            );
          }).toList(),

          const SizedBox(height: 16),
          const Text(
            'To do means you have not answered yet. '
            'Sent means you are waiting for the grade.',
            style: TextStyle(fontSize: 13, color: AppColors.mutedText),
          ),
        ],
      ),
    );
  }
}
