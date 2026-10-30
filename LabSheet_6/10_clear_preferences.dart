// Dependency: shared_preferences
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: ClearPage()));

class ClearPage extends StatefulWidget {
  const ClearPage({super.key});
  @override
  State<ClearPage> createState() => _ClearPageState();
}

class _ClearPageState extends State<ClearPage> {
  final controller = TextEditingController();
  String stored = '';
  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async { final p = await SharedPreferences.getInstance(); if (mounted) setState(() => stored = p.getString('clearDemo') ?? ''); }
  Future<void> _save() async { final p = await SharedPreferences.getInstance(); await p.setString('clearDemo', controller.text); if (mounted) setState(() => stored = controller.text); }
  Future<void> _clear() async { final p = await SharedPreferences.getInstance(); await p.clear(); if (mounted) setState(() => stored = ''); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Clear Saved Data')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: controller, decoration: const InputDecoration(labelText: 'Text to save')),
      ElevatedButton(onPressed: _save, child: const Text('Save')), Text('Stored: $stored'),
      ElevatedButton(onPressed: _clear, child: const Text('Clear all SharedPreferences')),
    ])));
  @override
  void dispose() { controller.dispose(); super.dispose(); }
}
