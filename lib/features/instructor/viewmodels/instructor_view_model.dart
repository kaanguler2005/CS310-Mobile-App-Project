import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../../data/models/instructor_course.dart';

class InstructorViewModel extends ChangeNotifier {
  final _random = Random();
  final _courses = <String, InstructorCourse>{
    'XK7-29Q': InstructorCourse(
      title: 'CS310 Mobile App Dev',
      description: 'Flutter and Dart basics and a team project.',
      joinCode: 'XK7-29Q',
      studentCount: 24,
      questions: [
        InstructorQuestion(
          title: 'Widget types',
          topic: 'Widgets',
          prompt:
              'What is the difference between a StatelessWidget and '
              'a StatefulWidget?',
        ),
        InstructorQuestion(
          title: 'Widget tree',
          topic: 'Widgets',
          prompt: 'How does Flutter use the widget tree to build a screen?',
          recipients: {1, 2, 5, 6, 7},
        ),
      ],
    ),
    'QP4-81M': InstructorCourse(
      title: 'CS204 Advanced Programming',
      description: 'Programming techniques and data structures.',
      joinCode: 'QP4-81M',
      studentCount: 31,
      questions: [
        for (final (title, prompt) in const [
          ('Complexity', 'Compare the cost of linear and binary search.'),
          ('Recursion', 'What is the base case of a recursive function?'),
          ('Lists', 'Compare arrays and linked lists.'),
          ('Trees', 'Explain an in-order traversal.'),
          ('Hashing', 'How can a hash table handle collisions?'),
        ])
          InstructorQuestion(
            title: title,
            topic: 'Data structures',
            prompt: prompt,
          ),
      ],
    ),
    'LM3-55T': InstructorCourse(
      title: 'IF100 Computational Approaches',
      description: 'An introduction to computational thinking.',
      joinCode: 'LM3-55T',
      studentCount: 48,
      questions: [
        for (final (title, prompt) in const [
          ('Algorithms', 'Describe an algorithm for sorting three numbers.'),
          ('Abstraction', 'Give an example of abstraction in software.'),
          ('Loops', 'Compare a while loop and a for loop.'),
          ('Conditionals', 'When would you use an else branch?'),
          ('Functions', 'What is a return value?'),
          ('Debugging', 'How would you locate an off-by-one error?'),
          ('Inputs', 'What makes a useful test input?'),
          ('Data types', 'Compare integers and strings.'),
        ])
          InstructorQuestion(
            title: title,
            topic: 'Programming',
            prompt: prompt,
          ),
      ],
    ),
  };

  List<InstructorCourse> get courses => List.unmodifiable(_courses.values);

  InstructorCourse courseFor(String joinCode) => _courses[joinCode]!;

  InstructorCourse createCourse(String title, String description) {
    final joinCode = _generateJoinCode();
    final course = InstructorCourse(
      title: title.trim(),
      description: description.trim(),
      joinCode: joinCode,
      studentCount: 0,
    );
    _courses[joinCode] = course;
    notifyListeners();
    return course;
  }

  void addQuestion(
    String joinCode, {
    required String topic,
    required String prompt,
    required Set<int>? recipients,
  }) {
    final course = courseFor(joinCode);
    _courses[joinCode] = course.withQuestion(
      InstructorQuestion(
        title: prompt.trim(),
        topic: topic.trim(),
        prompt: prompt.trim(),
        recipients: recipients,
      ),
    );
    notifyListeners();
  }

  String _generateJoinCode() {
    const characters = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    String group() => List.generate(
      3,
      (_) => characters[_random.nextInt(characters.length)],
    ).join();

    String code;
    do {
      code = '${group()}-${group()}';
    } while (_courses.containsKey(code));
    return code;
  }
}
