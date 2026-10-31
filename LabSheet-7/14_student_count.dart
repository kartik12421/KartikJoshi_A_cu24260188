// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(home: StudentCountPage()));
class StudentCountPage extends StatefulWidget { const StudentCountPage({super.key}); @override State<StudentCountPage> createState() => _StudentCountPageState(); }
class _StudentCountPageState extends State<StudentCountPage> {
  int count = 0;
  Future<void> loadCount() async { final path = p.join(await getDatabasesPath(), 'students.db'); final db = await openDatabase(path, version: 1, onCreate: (db, v) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)')); final result = await db.rawQuery('SELECT COUNT(*) AS total FROM students'); await db.close(); if (mounted) setState(() => count = Sqflite.firstIntValue(result) ?? 0); }
  @override
  void initState() { super.initState(); loadCount(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Student Record Count')), body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text('Total students: $count', style: Theme.of(context).textTheme.headlineSmall), ElevatedButton(onPressed: loadCount, child: const Text('Refresh count'))])));
}
