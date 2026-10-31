// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._(); static final instance = DatabaseHelper._(); static Database? _db;
  Future<Database> get database async => _db ??= await _open();
  Future<Database> _open() async => openDatabase(p.join(await getDatabasesPath(), 'students.db'), version: 1, onCreate: (db, v) => db.execute('CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)'));
  Future<int> insert(Map<String, Object?> student) async => (await database).insert('students', student);
  Future<List<Map<String, Object?>>> readAll() async => (await database).query('students', orderBy: 'name');
  Future<int> update(int id, Map<String, Object?> student) async => (await database).update('students', student, where: 'id = ?', whereArgs: [id]);
  Future<int> delete(int id) async => (await database).delete('students', where: 'id = ?', whereArgs: [id]);
}

void main() => runApp(const MaterialApp(home: HelperDemoPage()));
class HelperDemoPage extends StatefulWidget { const HelperDemoPage({super.key}); @override State<HelperDemoPage> createState() => _HelperDemoPageState(); }
class _HelperDemoPageState extends State<HelperDemoPage> {
  final name = TextEditingController(), roll = TextEditingController(), course = TextEditingController(); List<Map<String, Object?>> students = [];
  Future<void> refresh() async { final rows = await DatabaseHelper.instance.readAll(); if (mounted) setState(() => students = rows); }
  Future<void> add() async { if ([name.text, roll.text, course.text].any((v) => v.trim().isEmpty)) return; await DatabaseHelper.instance.insert({'name': name.text.trim(), 'rollNumber': roll.text.trim(), 'course': course.text.trim()}); name.clear(); roll.clear(); course.clear(); await refresh(); }
  @override
  void initState() { super.initState(); refresh(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('DatabaseHelper CRUD')), body: Column(children: [TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')), TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll number')), TextField(controller: course, decoration: const InputDecoration(labelText: 'Course')), ElevatedButton(onPressed: add, child: const Text('Insert')), Expanded(child: ListView(children: students.map((s) => ListTile(title: Text('${s['name']}'), subtitle: Text('${s['rollNumber']} • ${s['course']}'), onTap: () async { await DatabaseHelper.instance.update(s['id'] as int, {'name': '${s['name']} (edited)', 'rollNumber': s['rollNumber'], 'course': s['course']}); await refresh(); }, trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () async { await DatabaseHelper.instance.delete(s['id'] as int); await refresh(); })) ).toList()))]));
  @override
  void dispose() { name.dispose(); roll.dispose(); course.dispose(); super.dispose(); }
}
