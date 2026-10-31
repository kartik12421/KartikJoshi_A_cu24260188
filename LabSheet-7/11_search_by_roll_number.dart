// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(home: SearchStudentPage()));
class SearchStudentPage extends StatefulWidget { const SearchStudentPage({super.key}); @override State<SearchStudentPage> createState() => _SearchStudentPageState(); }
class _SearchStudentPageState extends State<SearchStudentPage> {
  final roll = TextEditingController(); Map<String, Object?>? student;
  Future<void> search() async {
    final path = p.join(await getDatabasesPath(), 'students.db');
    final db = await openDatabase(path, version: 1, onCreate: (db, v) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)'));
    final result = await db.query('students', where: 'rollNumber = ?', whereArgs: [roll.text.trim()], limit: 1); await db.close();
    if (mounted) setState(() => student = result.isEmpty ? null : result.first);
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Search Student')), body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll number')), ElevatedButton(onPressed: search, child: const Text('Search')), const SizedBox(height: 16), Text(student == null ? 'No result yet.' : '${student!['name']} • ${student!['rollNumber']} • ${student!['course']}')])));
  @override
  void dispose() { roll.dispose(); super.dispose(); }
}
