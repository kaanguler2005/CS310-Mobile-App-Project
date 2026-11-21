import 'package:flutter/material.dart';

import '../../shared/models/question.dart';
import '../../app/theme/colors.dart';
import '../../shared/widgets/confirmation_dialog.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/section_title.dart';

/// S10 Answer a question
///
/// The student writes an answer and sends it. A small window asks the
/// student to confirm first.
///
/// When readOnly is true the question has already been sent: the answer is
/// shown as plain text and Send answer is hidden.
class AnswerQuestionScreen extends StatefulWidget {
  const AnswerQuestionScreen({
    super.key,
    required this.question,
    required this.readOnly,
    required this.onSubmit,
  });

  final Question question;
  final bool readOnly;
  final void Function(String answer) onSubmit;

  @override
  State<AnswerQuestionScreen> createState() => _AnswerQuestionScreenState();
}

class _AnswerQuestionScreenState extends State<AnswerQuestionScreen> {
  final TextEditingController _controller = TextEditingController();

  bool askSend = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.question.myAnswer;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final String answer = _controller.text.trim();
    setState(() {
      askSend = false;
    });
    widget.onSubmit(answer);
    Navigator.pop(context);
  }

  Widget _questionBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        border: Border.all(color: AppColors.fieldBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        widget.question.text,
        style: const TextStyle(fontSize: 15, color: AppColors.text),
      ),
    );
  }

  Widget _answerBox() {
    if (widget.readOnly) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.fieldFill,
          border: Border.all(color: AppColors.fieldBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          widget.question.myAnswer,
          style: const TextStyle(fontSize: 15, color: AppColors.text),
        ),
      );
    }

    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        hintText: 'Write your answer here...',
      ),
      onChanged: (String value) {
        setState(() {});
      },
    );
  }

  Widget _content() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionTitle(
          text: '${widget.question.code}  ${widget.question.topic.toUpperCase()}',
        ),
        _questionBox(),
        const SectionTitle(text: 'YOUR ANSWER'),
        _answerBox(),
        const SizedBox(height: 20),

        widget.readOnly
            ? const Text(
                'This answer has been sent. You are waiting for the grade.',
                style: TextStyle(fontSize: 13, color: AppColors.mutedText),
              )
            : FilledButton(
                onPressed: _controller.text.trim().isEmpty
                    ? null
                    : () {
                        setState(() {
                          askSend = true;
                        });
                      },
                child: const Text('Send answer'),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(title: 'Answer the question'),
      body: Stack(
        children: [
          _content(),
          askSend
              ? ConfirmationDialog(
                  title: 'Send this answer?',
                  message: 'You cannot change it after you send it.',
                  confirmLabel: 'Send',
                  onCancel: () {
                    setState(() {
                      askSend = false;
                    });
                  },
                  onConfirm: _send,
                )
              : const SizedBox(width: 0, height: 0),
        ],
      ),
    );
  }
}
