// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(home: StudentEntryPage()));
class StudentEntryPage extends StatefulWidget { const StudentEntryPage({super.key}); @override State<StudentEntryPage> createState() => _StudentEntryPageState(); }
class _StudentEntryPageState extends State<StudentEntryPage> {
  final name = TextEditingController(), roll = TextEditingController(), course = TextEditingController();
  Future<void> save() async {
    if ([name.text, roll.text, course.text].any((v) => v.trim().isEmpty)) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Complete all fields'))); return; }
    final path = p.join(await getDatabasesPath(), 'students.db');
    final db = await openDatabase(path, version: 1, onCreate: (db, v) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)'));
    try { await db.insert('students', {'name': name.text.trim(), 'rollNumber': roll.text.trim(), 'course': course.text.trim()}); if (mounted) { name.clear(); roll.clear(); course.clear(); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student saved'))); } }
    on DatabaseException catch (e) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not save student: $e'))); } finally { await db.close(); }
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Add Student')), body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')), TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll number')), TextField(controller: course, decoration: const InputDecoration(labelText: 'Course')), const SizedBox(height: 16), ElevatedButton(onPressed: save, child: const Text('Save student'))])));
  @override
  void dispose() { name.dispose(); roll.dispose(); course.dispose(); super.dispose(); }
}
