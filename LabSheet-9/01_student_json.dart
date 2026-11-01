// Question 1: Parse a JSON array into Student objects.
import 'dart:convert';

class Student {
  final int id;
  final String name;
  final String course;
  const Student({required this.id, required this.name, required this.course});
  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json['id'] as int,
    name: json['name'] as String,
    course: json['course'] as String,
  );
  @override
  String toString() => 'Student(id: $id, name: $name, course: $course)';
}

void main() {
  const jsonText = '[{"id":1,"name":"Asha","course":"Flutter"},'
      '{"id":2,"name":"Ravi","course":"Dart"}]';
  final students = (jsonDecode(jsonText) as List<dynamic>)
      .map((item) => Student.fromJson(item as Map<String, dynamic>))
      .toList();
  for (final student in students) print(student);
}
