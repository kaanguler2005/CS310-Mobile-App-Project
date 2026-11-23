import '../shared/models/question.dart';
import '../shared/models/student_answer.dart';

class QuestionStore {
  static final Map<String, List<Question>> _questions = {};
  static final Map<String, List<StudentAnswer>> _answers = {};

  static List<Question> forCourse(String courseCode) {
    return _questions.putIfAbsent(
      courseCode,
      () => courseCode == 'CS310' ? _sampleQuestions() : <Question>[],
    );
  }

  static List<StudentAnswer> answersFor(String joinCode, String questionTitle) {
    return _answers.putIfAbsent('$joinCode/$questionTitle', _sampleAnswers);
  }

  static List<Question> _sampleQuestions() {
    return [
      Question(
        code: 'Q1',
        title: 'Widget types',
        topic: 'Widgets',
        text: 'What is the difference between a StatelessWidget and a '
            'StatefulWidget?',
        status: 'To do',
      ),
      Question(
        code: 'Q2',
        title: 'Widget tree',
        topic: 'Widgets',
        text: 'What is a widget tree?',
        status: 'Graded',
        myAnswer: 'The widget tree is the order of widgets that builds '
            'the screen.',
        grade: '85',
        comments: 'Good answer. Also say that the widget is built again '
            'after setState().',
        gradedBy: 'Instructor 1',
      ),
      Question(
        code: 'Q3',
        title: 'Navigation',
        topic: 'Navigation',
        text: 'What does Navigator.push add to the stack?',
        status: 'Sent',
        myAnswer: 'It adds a new route above the screen you are on.',
      ),
    ];
  }

  static List<StudentAnswer> _sampleAnswers() {
    return [
      StudentAnswer(
        studentName: 'Student 1',
        sentAt: 'sent 4 November, 21:10',
        answerText: 'A StatelessWidget never changes. A StatefulWidget can '
            'change.',
      ),
      StudentAnswer(
        studentName: 'Student 2',
        sentAt: 'sent 4 November, 18:42',
        answerText: 'StatefulWidget keeps a State object that can hold data '
            'that changes.',
        grade: '85',
        comments: 'Good. Add an example next time.',
      ),
      StudentAnswer(
        studentName: 'Student 3',
        sentAt: 'sent 5 November, 09:05',
        answerText: 'One of them uses setState.',
      ),
    ];
  }
}
