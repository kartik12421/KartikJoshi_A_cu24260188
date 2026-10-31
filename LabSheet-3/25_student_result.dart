import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: ResultApp()));

class ResultApp extends StatefulWidget {
  const ResultApp({super.key});
  State<ResultApp> createState() => _ResultAppState();
}

class _ResultAppState extends State<ResultApp> {
  final n = TextEditingController(), a = TextEditingController(), b = TextEditingController(), c = TextEditingController();
  String r = '';

  void result() {
    double total = double.parse(a.text) + double.parse(b.text) + double.parse(c.text);
    double per = total / 3;
    setState(() => r = 'Name: ${n.text}\nTotal: $total\nPercentage: ${per.toStringAsFixed(2)}%\n${per >= 40 ? 'PASS' : 'FAIL'}');
  }

  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Student Result')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: n, decoration: const InputDecoration(labelText: 'Name')),
      TextField(controller: a, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Subject 1')),
      TextField(controller: b, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Subject 2')),
      TextField(controller: c, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Subject 3')),
      ElevatedButton(onPressed: result, child: const Text('Result')),
      Text(r, textAlign: TextAlign.center),
    ])),
  );
}