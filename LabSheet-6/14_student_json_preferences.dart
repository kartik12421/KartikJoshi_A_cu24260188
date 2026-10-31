// Dependency: shared_preferences
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student {
  final String name, rollNumber, course;
  const Student({required this.name, required this.rollNumber, required this.course});
  Map<String, dynamic> toMap() => {'name': name, 'rollNumber': rollNumber, 'course': course};
  factory Student.fromMap(Map<String, dynamic> map) => Student(name: map['name'] as String, rollNumber: map['rollNumber'] as String, course: map['course'] as String);
}

void main() => runApp(const MaterialApp(home: StudentJsonPage()));

class StudentJsonPage extends StatefulWidget {
  const StudentJsonPage({super.key});
  @override
  State<StudentJsonPage> createState() => _StudentJsonPageState();
}

class _StudentJsonPageState extends State<StudentJsonPage> {
  final name = TextEditingController(), roll = TextEditingController(), course = TextEditingController();
  Student? student;
  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async {
    final p = await SharedPreferences.getInstance(); final raw = p.getString('studentJson'); if (raw == null) return;
    try { final value = Student.fromMap(jsonDecode(raw) as Map<String, dynamic>); if (mounted) setState(() { student = value; name.text = value.name; roll.text = value.rollNumber; course.text = value.course; }); } catch (_) { if (mounted) setState(() => student = null); }
  }
  Future<void> _save() async {
    final value = Student(name: name.text.trim(), rollNumber: roll.text.trim(), course: course.text.trim());
    final p = await SharedPreferences.getInstance(); await p.setString('studentJson', jsonEncode(value.toMap()));
    if (mounted) setState(() => student = value);
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Student JSON Storage')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
      TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll number')),
      TextField(controller: course, decoration: const InputDecoration(labelText: 'Course')),
      ElevatedButton(onPressed: _save, child: const Text('Save student')),
      if (student != null) Text('Saved student: ${student!.name}, ${student!.rollNumber}, ${student!.course}'),
    ])));
  @override
  void dispose() { name.dispose(); roll.dispose(); course.dispose(); super.dispose(); }
}
