// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(home: RawQueryPage()));
class RawQueryPage extends StatefulWidget { const RawQueryPage({super.key}); @override State<RawQueryPage> createState() => _RawQueryPageState(); }
class _RawQueryPageState extends State<RawQueryPage> {
  List<Map<String, Object?>> rows = [];
  Future<void> load() async {
    final path = p.join(await getDatabasesPath(), 'students.db');
    final db = await openDatabase(path, version: 1, onCreate: (db, v) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)'));
    final result = await db.rawQuery('SELECT id, name, rollNumber, course FROM students ORDER BY id'); await db.close();
    if (mounted) setState(() => rows = result);
  }
  @override
  void initState() { super.initState(); load(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Students (rawQuery)')), body: Column(children: [ElevatedButton(onPressed: load, child: const Text('Run rawQuery')), Expanded(child: ListView(children: rows.map((s) => ListTile(title: Text('${s['name']}'), subtitle: Text('${s['rollNumber']} • ${s['course']}'))).toList()))]));
}
