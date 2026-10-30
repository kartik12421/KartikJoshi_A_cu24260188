import 'dart:convert';

void main() {
  final student = <String, dynamic>{'name': 'Aarav Sharma', 'rollNumber': 101, 'course': 'Computer Science'};
  final jsonString = jsonEncode(student);
  final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
  print('JSON: $jsonString');
  print('Decoded map: $decoded');
}
