// Lab Sheet 8 - Question 7: Search contacts by name using SQLite LIKE.
// Dependencies: Flutter SDK, sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: RecordsPage()));

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});
  @override State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  Database? _db;
  List<Map<String, Object?>> rows = [];
  final queryController = TextEditingController();
  bool completed = false;
  final fields = ['name', 'phone'];

  @override void initState() { super.initState(); _open(); }
  Future<void> _open() async {
    final path = p.join(await getDatabasesPath(), 'contacts.db');
    _db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, phone TEXT NOT NULL)');
    });
    await _load();
  }
  Future<void> _load() async {
    final db = _db; if (db == null) return;
    var result = await db.query('contacts', orderBy: 'id DESC');
    final query = queryController.text.trim();
    if (query.isNotEmpty) result = await db.query('contacts', where: 'name LIKE ?', whereArgs: ['%$query%'], orderBy: 'id DESC');
    if (mounted) setState(() => rows = result);
  }
  Future<void> _save([Map<String, Object?>? existing]) async {
    final controllers = <String, TextEditingController>{};
    for (final field in fields) controllers[field] = TextEditingController(text: existing?[field]?.toString() ?? '');
    if (existing == null) completed = false;
    final formKey = GlobalKey<FormState>();
    final values = await showDialog<Map<String, Object?>>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(existing == null ? 'Add record' : 'Edit record'),
        content: Form(key: formKey, child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(controller: controllers['name'], decoration: const InputDecoration(labelText: 'Name'), keyboardType: TextInputType.text, obscureText: false, validator: (v) { if ((v ?? '').trim().isEmpty) return 'Required';     return null; }),
          TextFormField(controller: controllers['phone'], decoration: const InputDecoration(labelText: 'Phone number'), keyboardType: TextInputType.text, obscureText: false, validator: (v) { if ((v ?? '').trim().isEmpty) return 'Required';     return null; })
        ]))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          FilledButton(onPressed: () { if (formKey.currentState!.validate()) {
            Navigator.pop(dialogContext, <String, Object?>{'name': controllers['name']!.text.trim(), 'phone': controllers['phone']!.text.trim()});
          } }, child: const Text('Save')),
        ],
      ),
    );
    for (final controller in controllers.values) controller.dispose();
    if (values == null || _db == null) return;
    if (existing != null) values['id'] = existing['id'];
    await _db!.insert('contacts', values, conflictAlgorithm: ConflictAlgorithm.replace);
    await _load();
  }
  Future<void> _delete(int id) async { await _db?.delete('contacts', where: 'id = ?', whereArgs: [id]); await _load(); }
  Future<bool> _confirmDelete() async => await showDialog<bool>(context: context, builder: (c) => AlertDialog(
    title: const Text('Delete record?'), content: const Text('This action cannot be undone.'),
    actions: [TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Delete'))],
  )) ?? false;
  Future<void> _toggle(Map<String,Object?> row) async {
    final db = _db; if (db == null) return;
    await db.update('tasks', {'completed': (row['completed'] as int? ?? 0) == 1 ? 0 : 1}, where: 'id = ?', whereArgs: [row['id']]);
    await _load();
  }
  @override void dispose() { queryController.dispose(); super.dispose(); }

  @override Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Book')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(12), child: TextField(controller: queryController, decoration: const InputDecoration(labelText: 'Search by title', prefixIcon: Icon(Icons.search)), onChanged: (_) => _load())),
        
        Expanded(child: rows.isEmpty ? const Center(child: Text('No records yet. Tap + to add one.')) : ListView.builder(
          itemCount: rows.length,
          itemBuilder: (context, index) { final row = rows[index];
            return ListTile(
              leading: CircleAvatar(child: Text('${index+1}')),
              title: Text((row['name'] ?? '').toString()), subtitle: Text('${fields[1]}: ${row['${fields[1]}']}'),
              
              trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () async { await _delete(row['id'] as int); }),
            );
          })),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () => _save(), child: const Icon(Icons.add)),
    );
  }
}
