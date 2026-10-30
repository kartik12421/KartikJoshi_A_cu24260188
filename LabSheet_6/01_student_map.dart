void main() {
  final student = <String, String>{
    'name': 'Aarav Sharma',
    'rollNumber': '23CS101',
    'course': 'Computer Science',
  };

  student.forEach((key, value) => print('$key: $value'));
}
