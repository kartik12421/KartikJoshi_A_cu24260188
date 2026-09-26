import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: CalculatorApp()));

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final a = TextEditingController(), b = TextEditingController();
  String r = '';

  void calc(String op) {
    double x = double.parse(a.text), y = double.parse(b.text);
    double z = op == '+' ? x + y : op == '-' ? x - y : op == '*' ? x * y : x / y;
    setState(() => r = '$z');
  }

  Widget build(BuildContext context) => Scaffold(
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: a, keyboardType: TextInputType.number),
      TextField(controller: b, keyboardType: TextInputType.number),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children:
        ['+','-','*','/'].map((x) => ElevatedButton(onPressed: () => calc(x), child: Text(x))).toList()),
      Text(r),
    ])),
  );
}