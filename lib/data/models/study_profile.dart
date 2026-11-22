enum StudyRole {
  student('Student'),
  instructor('Instructor');

  const StudyRole(this.label);
  final String label;
}

class StudyProfile {
  const StudyProfile({
    required this.displayName,
    required this.email,
    required this.role,
    this.photoUrl = '',
  });

  final String displayName;
  final String email;
  final StudyRole role;
  final String photoUrl;
}
