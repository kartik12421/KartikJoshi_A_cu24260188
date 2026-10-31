import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MarksApp()));

class MarksApp extends StatefulWidget {
  const MarksApp({super.key});
  State<MarksApp> createState() => _MarksAppState();
}

class _MarksAppState extends State<MarksApp> {
  final n = TextEditingController(), a = TextEditingController(), b = TextEditingController(), c = TextEditingController();
  String r = '';

  void total() => setState(() => r =
    'Name: ${n.text}\nTotal: ${int.parse(a.text)+int.parse(b.text)+int.parse(c.text)}');

  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        TextField(controller: n, decoration: const InputDecoration(labelText: 'Name')),
        TextField(controller: a, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Subject 1')),
        TextField(controller: b, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Subject 2')),
        TextField(controller: c, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Subject 3')),
        ElevatedButton(onPressed: total, child: const Text('Calculate')),
        Text(r),
      ]),
    ),
  );
}