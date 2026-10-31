// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class Student {
  final int? id; final String name, rollNumber, course;
  const Student({this.id, required this.name, required this.rollNumber, required this.course});
  Map<String, Object?> toMap() => {'id': id, 'name': name, 'rollNumber': rollNumber, 'course': course};
  factory Student.fromMap(Map<String, Object?> map) => Student(id: map['id'] as int?, name: map['name'] as String, rollNumber: map['rollNumber'] as String, course: map['course'] as String);
}

void main() => runApp(const MaterialApp(home: StudentModelPage()));
class StudentModelPage extends StatefulWidget { const StudentModelPage({super.key}); @override State<StudentModelPage> createState() => _StudentModelPageState(); }
class _StudentModelPageState extends State<StudentModelPage> {
  List<Student> students = [];
  Future<Database> database() async { final path = p.join(await getDatabasesPath(), 'students.db'); return openDatabase(path, version: 1, onCreate: (db, v) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)')); }
  Future<void> reload() async { final db = await database(); final rows = await db.query('students'); await db.close(); if (mounted) setState(() => students = rows.map(Student.fromMap).toList()); }
  Future<void> addSample() async { final db = await database(); await db.insert('students', const Student(name: 'Aarav Sharma', rollNumber: '23CS101', course: 'Computer Science').toMap(), conflictAlgorithm: ConflictAlgorithm.replace); await db.close(); await reload(); }
  @override
  void initState() { super.initState(); reload(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Student Model')), floatingActionButton: FloatingActionButton(onPressed: addSample, child: const Icon(Icons.add)), body: ListView(children: students.map((s) => ListTile(title: Text(s.name), subtitle: Text('${s.rollNumber} • ${s.course}'))).toList()));
}
