// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(home: UpdateStudentPage()));
class UpdateStudentPage extends StatefulWidget { const UpdateStudentPage({super.key}); @override State<UpdateStudentPage> createState() => _UpdateStudentPageState(); }
class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final roll = TextEditingController(), name = TextEditingController(), course = TextEditingController();
  Future<void> updateStudent() async {
    if (roll.text.trim().isEmpty) return;
    final path = p.join(await getDatabasesPath(), 'students.db');
    final db = await openDatabase(path, version: 1, onCreate: (db, v) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)'));
    final values = <String, Object?>{}; if (name.text.trim().isNotEmpty) values['name'] = name.text.trim(); if (course.text.trim().isNotEmpty) values['course'] = course.text.trim();
    final count = values.isEmpty ? 0 : await db.update('students', values, where: 'rollNumber = ?', whereArgs: [roll.text.trim()]); await db.close();
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(count == 0 ? 'No student updated; check the roll number and fields.' : 'Student updated')));
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Update Student')), body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll number to find')), TextField(controller: name, decoration: const InputDecoration(labelText: 'New name (optional)')), TextField(controller: course, decoration: const InputDecoration(labelText: 'New course (optional)')), ElevatedButton(onPressed: updateStudent, child: const Text('Update'))])));
  @override
  void dispose() { roll.dispose(); name.dispose(); course.dispose(); super.dispose(); }
}
