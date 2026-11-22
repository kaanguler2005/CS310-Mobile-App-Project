class InstructorQuestion {
  InstructorQuestion({
    required this.title,
    required this.topic,
    required this.prompt,
    Set<int>? recipients,
  }) : recipients = recipients == null ? null : Set.unmodifiable(recipients);

  final String title;
  final String topic;
  final String prompt;
  final Set<int>? recipients;

  String get audienceLabel {
    final count = recipients?.length;
    return switch (count) {
      null => 'all students',
      1 => '1 student',
      _ => '$count students',
    };
  }
}

class InstructorCourse {
  InstructorCourse({
    required this.title,
    required this.description,
    required this.joinCode,
    required this.studentCount,
    Iterable<InstructorQuestion> questions = const [],
  }) : questions = List.unmodifiable(questions);

  final String title;
  final String description;
  final String joinCode;
  final int studentCount;
  final List<InstructorQuestion> questions;

  InstructorCourse withQuestion(InstructorQuestion question) {
    return InstructorCourse(
      title: title,
      description: description,
      joinCode: joinCode,
      studentCount: studentCount,
      questions: [...questions, question],
    );
  }
}
