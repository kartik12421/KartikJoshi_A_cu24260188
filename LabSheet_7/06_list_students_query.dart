// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(home: StudentsListPage()));
class StudentsListPage extends StatefulWidget { const StudentsListPage({super.key}); @override State<StudentsListPage> createState() => _StudentsListPageState(); }
class _StudentsListPageState extends State<StudentsListPage> {
  List<Map<String, Object?>> students = [];
  Future<void> load() async {
    final path = p.join(await getDatabasesPath(), 'students.db');
    final db = await openDatabase(path, version: 1, onCreate: (db, v) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)'));
    final rows = await db.query('students', orderBy: 'name ASC'); await db.close();
    if (mounted) setState(() => students = rows);
  }
  @override
  void initState() { super.initState(); load(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Students')), floatingActionButton: FloatingActionButton(onPressed: load, child: const Icon(Icons.refresh)), body: students.isEmpty ? const Center(child: Text('No students found. Add records first.')) : ListView.builder(itemCount: students.length, itemBuilder: (_, i) { final s = students[i]; return ListTile(title: Text('${s['name']} (${s['rollNumber']})'), subtitle: Text('${s['course']}  •  ID ${s['id']}')); }));
}
