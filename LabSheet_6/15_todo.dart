// Dependency: shared_preferences
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: TodoPage()));

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final input = TextEditingController(); List<String> tasks = [];
  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async { final p = await SharedPreferences.getInstance(); if (mounted) setState(() => tasks = p.getStringList('todoTasks') ?? []); }
  Future<void> _save() async { final p = await SharedPreferences.getInstance(); await p.setStringList('todoTasks', tasks); }
  Future<void> _add() async { final task = input.text.trim(); if (task.isEmpty) return; setState(() { tasks = [...tasks, task]; input.clear(); }); await _save(); }
  Future<void> _remove(int index) async { setState(() => tasks.removeAt(index)); await _save(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('To-Do List')),
    body: Column(children: [Padding(padding: const EdgeInsets.all(16), child: Row(children: [
      Expanded(child: TextField(controller: input, decoration: const InputDecoration(labelText: 'New task'))),
      IconButton(onPressed: _add, icon: const Icon(Icons.add)),
    ])), Expanded(child: ListView.builder(itemCount: tasks.length, itemBuilder: (_, i) => ListTile(title: Text(tasks[i]), trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => _remove(i)))))]));
  @override
  void dispose() { input.dispose(); super.dispose(); }
}
