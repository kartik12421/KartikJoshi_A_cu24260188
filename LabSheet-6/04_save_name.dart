// Dependency: shared_preferences
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: NamePage()));

class NamePage extends StatefulWidget {
  const NamePage({super.key});
  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final controller = TextEditingController();
  String name = '';
  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() { name = prefs.getString('name') ?? ''; controller.text = name; });
  }
  Future<void> _save() async {
    final value = controller.text.trim();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', value);
    if (mounted) setState(() => name = value);
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Save Your Name')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: controller, decoration: const InputDecoration(labelText: 'Name')),
      ElevatedButton(onPressed: _save, child: const Text('Save')),
      Text(name.isEmpty ? 'No name saved' : 'Welcome, $name!'),
    ])),
  );
  @override
  void dispose() { controller.dispose(); super.dispose(); }
}
