class SelectedCourse {
  String courseCode;
  String courseName;
  String status;
  SelectedCourse(this.courseCode, this.courseName, this.status);
}

class Flashcard {
  String question;
  String answer;
  Flashcard(this.question, this.answer);
}

class Profile {
  String? photoURL;
  String displayName = "Kaan"; // TODO by default user's email address!
  String role = "Student"; // TODO may be enum { 'Student', 'Instructor' }
  List<SelectedCourse> selectedCourses = [
    SelectedCourse("CS310", "Mobile App Dev", "2 questions to answer"),
    SelectedCourse("MATH203", "Introduction to Probability", "nothing new"),
  ];
  int sessionsToday() {
    return 2;
  }

  List<Flashcard> mineFlashcards = [
    Flashcard("What is a Widget?", "Widget is a small Flutter element."),
    Flashcard(
      "What is setState()",
      "It tells Flutter to build the screen again.",
    ),
    Flashcard(
      "Stateless or Stateful",
      "It depends which page you want to implement.",
    ),
    Flashcard(
      "What is Navigator?",
      "Useful widget which is used to travel amongst pages.",
    ),
  ];
  List<Flashcard> sharedFlashcards = [
    Flashcard("What is a Widget?", "Widget is a small Flutter element."),
    Flashcard("What is dart", "Not a game, a programming language."),
  ];
}
