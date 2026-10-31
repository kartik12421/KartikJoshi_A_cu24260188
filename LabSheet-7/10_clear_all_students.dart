// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(home: ClearStudentsPage()));
class ClearStudentsPage extends StatelessWidget {
  const ClearStudentsPage({super.key});
  Future<int> clearAll() async {
    final path = p.join(await getDatabasesPath(), 'students.db');
    final db = await openDatabase(path, version: 1, onCreate: (db, v) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)'));
    final count = await db.delete('students'); await db.close(); return count;
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Clear Students')), body: Center(child: ElevatedButton.icon(icon: const Icon(Icons.delete_forever), label: const Text('Clear All'), onPressed: () async { final count = await clearAll(); if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Removed $count student record(s)'))); })));
}
