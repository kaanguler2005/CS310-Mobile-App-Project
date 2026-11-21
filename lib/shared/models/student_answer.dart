/// One answer a student sent for one question.
/// Used by S19 (the list) and S20 (grading one of them).
class StudentAnswer {
  StudentAnswer({
    required this.studentName,
    required this.sentAt,
    required this.answerText,
    this.grade = '',
    this.comments = '',
  });

  final String studentName;
  final String sentAt;
  final String answerText;

  String grade;
  String comments;

  String statusLabel() {
    if (grade.isEmpty) {
      return 'Not graded';
    }
    return '$grade / 100';
  }
}
