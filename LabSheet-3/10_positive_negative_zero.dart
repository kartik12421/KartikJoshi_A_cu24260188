import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: NumberApp()));

class NumberApp extends StatefulWidget {
  const NumberApp({super.key});
  State<NumberApp> createState() => _NumberAppState();
}

class _NumberAppState extends State<NumberApp> {
  final c = TextEditingController();
  String r = '';

  void check() {
    double n = double.parse(c.text);
    setState(() => r = n > 0 ? 'Positive' : n < 0 ? 'Negative' : 'Zero');
  }

  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: c, keyboardType: TextInputType.number),
      ElevatedButton(onPressed: check, child: const Text('Check')),
      Text(r),
    ])),
  );
}