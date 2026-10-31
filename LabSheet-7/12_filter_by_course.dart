// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(home: CourseStudentsPage()));
class CourseStudentsPage extends StatefulWidget { const CourseStudentsPage({super.key}); @override State<CourseStudentsPage> createState() => _CourseStudentsPageState(); }
class _CourseStudentsPageState extends State<CourseStudentsPage> {
  final courses = ['Computer Science', 'Information Technology', 'Electronics']; String course = 'Computer Science'; List<Map<String, Object?>> students = [];
  Future<void> load() async {
    final path = p.join(await getDatabasesPath(), 'students.db');
    final db = await openDatabase(path, version: 1, onCreate: (db, v) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)'));
    final rows = await db.query('students', where: 'course = ?', whereArgs: [course], orderBy: 'name'); await db.close(); if (mounted) setState(() => students = rows);
  }
  @override
  void initState() { super.initState(); load(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Students by Course')), body: Column(children: [Padding(padding: const EdgeInsets.all(16), child: DropdownButtonFormField<String>(value: course, items: courses.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (c) { if (c != null) { setState(() => course = c); load(); } })), Expanded(child: students.isEmpty ? const Center(child: Text('No students in this course')) : ListView(children: students.map((s) => ListTile(title: Text('${s['name']}'), subtitle: Text('${s['rollNumber']} • ${s['course']}'))).toList()))]));
}
