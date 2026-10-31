// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(home: CreateTablePage()));

class CreateTablePage extends StatelessWidget {
  const CreateTablePage({super.key});
  Future<void> createTable() async {
    final path = p.join(await getDatabasesPath(), 'students.db');
    final db = await openDatabase(path);
    await db.execute('CREATE TABLE IF NOT EXISTS students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)');
    await db.close();
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Create Students Table')), body: Center(child: ElevatedButton(onPressed: () async { await createTable(); if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Students table is ready'))); }, child: const Text('Create table'))));
}
