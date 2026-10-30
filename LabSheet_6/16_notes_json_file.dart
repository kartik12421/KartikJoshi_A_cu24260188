// Dependencies: path_provider
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const MaterialApp(home: NotesPage()));

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final input = TextEditingController(); List<String> notes = []; bool loading = true;
  Future<File> _file() async { final dir = await getApplicationDocumentsDirectory(); return File('${dir.path}/notes.json'); }
  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async {
    try { final file = await _file(); if (await file.exists()) { final decoded = jsonDecode(await file.readAsString()) as List<dynamic>; notes = decoded.map((e) => e as String).toList(); } }
    catch (_) { notes = []; }
    if (mounted) setState(() => loading = false);
  }
  Future<void> _persist() async { final file = await _file(); await file.writeAsString(jsonEncode(notes)); }
  Future<void> _add() async { final note = input.text.trim(); if (note.isEmpty) return; setState(() { notes = [...notes, note]; input.clear(); }); await _persist(); }
  Future<void> _remove(int index) async { setState(() => notes.removeAt(index)); await _persist(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('JSON Notes')),
    body: Column(children: [Padding(padding: const EdgeInsets.all(16), child: Row(children: [
      Expanded(child: TextField(controller: input, decoration: const InputDecoration(labelText: 'Write a note'))),
      IconButton(onPressed: _add, icon: const Icon(Icons.add)),
    ])), Expanded(child: loading ? const Center(child: CircularProgressIndicator()) : ListView.builder(itemCount: notes.length, itemBuilder: (_, i) => ListTile(title: Text(notes[i]), trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => _remove(i)))))]));
  @override
  void dispose() { input.dispose(); super.dispose(); }
}
