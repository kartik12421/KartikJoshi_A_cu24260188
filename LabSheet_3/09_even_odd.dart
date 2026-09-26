import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: CheckApp()));

class CheckApp extends StatefulWidget {
  const CheckApp({super.key});
  State<CheckApp> createState() => _CheckAppState();
}

class _CheckAppState extends State<CheckApp> {
  final c = TextEditingController();
  String r = '';

  void check() {
    int n = int.parse(c.text);
    setState(() => r = n % 2 == 0 ? 'Even' : 'Odd');
  }

  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: c, keyboardType: TextInputType.number),
      ElevatedButton(onPressed: check, child: const Text('Check')),
      Text(r),
    ])),
  );
}