// Dependency: shared_preferences
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: ProfileValuesPage()));

class ProfileValuesPage extends StatefulWidget {
  const ProfileValuesPage({super.key});
  @override
  State<ProfileValuesPage> createState() => _ProfileValuesPageState();
}

class _ProfileValuesPageState extends State<ProfileValuesPage> {
  final name = TextEditingController(), email = TextEditingController(), age = TextEditingController();
  String saved = '';
  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (!mounted) return;
    name.text = p.getString('profileName') ?? ''; email.text = p.getString('profileEmail') ?? ''; age.text = p.getInt('profileAge')?.toString() ?? '';
    setState(() => saved = _summary());
  }
  String _summary() => 'Name: ${name.text}\nEmail: ${email.text}\nAge: ${age.text}';
  Future<void> _save() async {
    final parsedAge = int.tryParse(age.text.trim());
    if (parsedAge == null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a valid age'))); return; }
    final p = await SharedPreferences.getInstance();
    await p.setString('profileName', name.text.trim()); await p.setString('profileEmail', email.text.trim()); await p.setInt('profileAge', parsedAge);
    if (mounted) setState(() => saved = _summary());
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Profile Details')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
      TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
      TextField(controller: age, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Age')),
      ElevatedButton(onPressed: _save, child: const Text('Save')), Text(saved),
    ])));
  @override
  void dispose() { name.dispose(); email.dispose(); age.dispose(); super.dispose(); }
}
