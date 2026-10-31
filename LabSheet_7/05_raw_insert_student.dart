// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(home: RawInsertPage()));
class RawInsertPage extends StatelessWidget {
  const RawInsertPage({super.key});
  Future<void> insertStudent() async {
    final path = p.join(await getDatabasesPath(), 'students.db');
    final db = await openDatabase(path, version: 1, onCreate: (db, v) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)'));
    await db.rawInsert('INSERT OR REPLACE INTO students(name, rollNumber, course) VALUES(?, ?, ?)', ['Mira Patel', '23CS102', 'Computer Science']);
    await db.close();
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Insert with rawInsert')), body: Center(child: ElevatedButton(onPressed: () async { await insertStudent(); if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student inserted with rawInsert'))); }, child: const Text('Insert sample'))));
}
