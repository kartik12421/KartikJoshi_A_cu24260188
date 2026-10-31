// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(home: DeleteStudentPage()));
class DeleteStudentPage extends StatefulWidget { const DeleteStudentPage({super.key}); @override State<DeleteStudentPage> createState() => _DeleteStudentPageState(); }
class _DeleteStudentPageState extends State<DeleteStudentPage> {
  final roll = TextEditingController();
  Future<void> deleteStudent() async {
    final path = p.join(await getDatabasesPath(), 'students.db');
    final db = await openDatabase(path, version: 1, onCreate: (db, v) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)'));
    final count = await db.delete('students', where: 'rollNumber = ?', whereArgs: [roll.text.trim()]); await db.close();
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(count == 0 ? 'No student found with that roll number.' : 'Student deleted')));
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Delete Student')), body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll number')), ElevatedButton(onPressed: deleteStudent, child: const Text('Delete student'))])));
  @override
  void dispose() { roll.dispose(); super.dispose(); }
}
