import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: NameApp()));

class NameApp extends StatefulWidget {
  const NameApp({super.key});
  State<NameApp> createState() => _NameAppState();
}

class _NameAppState extends State<NameApp> {
  final c = TextEditingController();
  String name = '';

  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Student Name')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        TextField(controller: c, decoration: const InputDecoration(labelText: 'Name')),
        ElevatedButton(onPressed: () => setState(() => name = c.text), child: const Text('Show')),
        Text('Name: $name'),
      ]),
    ),
  );
}