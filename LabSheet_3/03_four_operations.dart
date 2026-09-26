import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: CalcApp()));

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});
  State<CalcApp> createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  final a = TextEditingController(), b = TextEditingController();
  String r = '';

  void calc(String op) {
    double x = double.parse(a.text), y = double.parse(b.text);
    double z = op == '+' ? x + y : op == '-' ? x - y : op == '*' ? x * y : x / y;
    setState(() => r = '$z');
  }

  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        TextField(controller: a, keyboardType: TextInputType.number),
        TextField(controller: b, keyboardType: TextInputType.number),
        Wrap(spacing: 8, children: ['+', '-', '*', '/']
          .map((x) => ElevatedButton(onPressed: () => calc(x), child: Text(x))).toList()),
        Text(r),
      ]),
    ),
  );
}