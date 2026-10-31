// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

Future<Database> openStudentDb() async {
  final path = p.join(await getDatabasesPath(), 'students.db');
  return openDatabase(path, version: 1, onCreate: (db, version) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)'));
}

void main() => runApp(const MaterialApp(home: InsertStudentPage()));
class InsertStudentPage extends StatelessWidget {
  const InsertStudentPage({super.key});
  Future<void> insert() async {
    final db = await openStudentDb();
    await db.insert('students', {'name': 'Aarav Sharma', 'rollNumber': '23CS101', 'course': 'Computer Science'}, conflictAlgorithm: ConflictAlgorithm.replace);
    await db.close();
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Insert Student')), body: Center(child: ElevatedButton(onPressed: () async { await insert(); if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student inserted'))); }, child: const Text('Insert sample student'))));
}
