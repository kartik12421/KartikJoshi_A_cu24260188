// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(home: OrderedStudentsPage()));
class OrderedStudentsPage extends StatefulWidget { const OrderedStudentsPage({super.key}); @override State<OrderedStudentsPage> createState() => _OrderedStudentsPageState(); }
class _OrderedStudentsPageState extends State<OrderedStudentsPage> {
  List<Map<String, Object?>> students = [];
  Future<void> load() async { final path = p.join(await getDatabasesPath(), 'students.db'); final db = await openDatabase(path, version: 1, onCreate: (db, v) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)')); final rows = await db.query('students', orderBy: 'name ASC'); await db.close(); if (mounted) setState(() => students = rows); }
  @override
  void initState() { super.initState(); load(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Students A–Z')), floatingActionButton: FloatingActionButton(onPressed: load, child: const Icon(Icons.refresh)), body: ListView(children: students.map((s) => ListTile(title: Text('${s['name']}'), subtitle: Text('${s['rollNumber']} • ${s['course']}'))).toList()));
}
