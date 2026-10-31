// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(home: CreateDatabasePage()));

class CreateDatabasePage extends StatefulWidget {
  const CreateDatabasePage({super.key});
  @override
  State<CreateDatabasePage> createState() => _CreateDatabasePageState();
}

class _CreateDatabasePageState extends State<CreateDatabasePage> {
  String status = 'Database has not been opened yet.';
  Future<void> createDatabase() async {
    final path = p.join(await getDatabasesPath(), 'students.db');
    await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, rollNumber TEXT, course TEXT)');
    });
    if (mounted) setState(() => status = 'Database created/opened successfully at $path');
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Create SQLite Database')), body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(status, textAlign: TextAlign.center), ElevatedButton(onPressed: createDatabase, child: const Text('Create database'))])));
}
