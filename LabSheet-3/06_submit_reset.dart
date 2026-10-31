import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: FormApp()));

class FormApp extends StatefulWidget {
  const FormApp({super.key});
  State<FormApp> createState() => _FormAppState();
}

class _FormAppState extends State<FormApp> {
  final c = TextEditingController();
  String msg = '';

  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        TextField(controller: c, decoration: const InputDecoration(labelText: 'Name')),
        Row(children: [
          ElevatedButton(onPressed: () => setState(() => msg = 'Submitted: ${c.text}'), child: const Text('Submit')),
          const SizedBox(width: 10),
          ElevatedButton(onPressed: () { c.clear(); setState(() => msg = ''); }, child: const Text('Reset')),
        ]),
        Text(msg),
      ]),
    ),
  );
}