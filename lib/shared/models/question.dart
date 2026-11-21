/// One question the instructor gave in a course.
///
/// Model class, as in the "Collections, Lists & Grids" lecture: the class
/// describes the data, each object holds the values of one question.
class Question {
  Question({
    required this.code,
    required this.title,
    required this.topic,
    required this.text,
    required this.status,
    this.myAnswer = '',
    this.grade = '',
    this.comments = '',
    this.gradedBy = '',
  });

  final String code;
  final String title;
  final String topic;
  final String text;

  String status;
  String myAnswer;

  String grade;
  String comments;
  String gradedBy;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      code: json['code'] as String,
      title: json['title'] as String,
      topic: json['topic'] as String,
      text: json['text'] as String,
      status: json['status'] as String,
      myAnswer: (json['myAnswer'] ?? '') as String,
      grade: (json['grade'] ?? '') as String,
      comments: (json['comments'] ?? '') as String,
      gradedBy: (json['gradedBy'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'title': title,
      'topic': topic,
      'text': text,
      'status': status,
      'myAnswer': myAnswer,
      'grade': grade,
      'comments': comments,
      'gradedBy': gradedBy,
    };
  }
}
