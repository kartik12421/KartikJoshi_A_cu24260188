import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: SumApp()));

class SumApp extends StatefulWidget {
  const SumApp({super.key});
  State<SumApp> createState() => _SumAppState();
}

class _SumAppState extends State<SumApp> {
  final a = TextEditingController(), b = TextEditingController();
  String result = '';

  void sum() => setState(() =>
      result = '${double.parse(a.text) + double.parse(b.text)}');

  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        TextField(controller: a, keyboardType: TextInputType.number),
        TextField(controller: b, keyboardType: TextInputType.number),
        ElevatedButton(onPressed: sum, child: const Text('Sum')),
        Text(result),
      ]),
    ),
  );
}