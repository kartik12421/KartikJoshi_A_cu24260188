// Dependency: shared_preferences
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: SubjectsPage()));

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({super.key});
  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  final input = TextEditingController();
  List<String> subjects = [];
  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (mounted) setState(() => subjects = p.getStringList('subjects') ?? []);
  }
  Future<void> _add() async {
    final value = input.text.trim(); if (value.isEmpty) return;
    final updated = [...subjects, value]; final p = await SharedPreferences.getInstance(); await p.setStringList('subjects', updated);
    if (mounted) setState(() { subjects = updated; input.clear(); });
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Favourite Subjects')),
    body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
      TextField(controller: input, decoration: InputDecoration(labelText: 'Subject', suffixIcon: IconButton(onPressed: _add, icon: const Icon(Icons.add)))),
      Expanded(child: ListView.builder(itemCount: subjects.length, itemBuilder: (_, i) => ListTile(title: Text(subjects[i])))),
    ])));
  @override
  void dispose() { input.dispose(); super.dispose(); }
}
