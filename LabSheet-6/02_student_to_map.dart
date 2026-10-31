class Student {
  final String name;
  final String rollNumber;
  final String course;

  const Student({required this.name, required this.rollNumber, required this.course});

  Map<String, dynamic> toMap() => {
        'name': name,
        'rollNumber': rollNumber,
        'course': course,
      };

  factory Student.fromMap(Map<String, dynamic> map) => Student(
        name: map['name'] as String,
        rollNumber: map['rollNumber'] as String,
        course: map['course'] as String,
      );

  @override
  String toString() => 'Student(name: $name, rollNumber: $rollNumber, course: $course)';
}

void main() {
  const original = Student(name: 'Aarav Sharma', rollNumber: '23CS101', course: 'Computer Science');
  final map = original.toMap();
  final restored = Student.fromMap(map);
  print('Map: $map');
  print('Restored: $restored');
}
