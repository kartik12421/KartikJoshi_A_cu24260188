import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: PercentageApp()));

class PercentageApp extends StatefulWidget {
  const PercentageApp({super.key});
  State<PercentageApp> createState() => _PercentageAppState();
}

class _PercentageAppState extends State<PercentageApp> {
  final a = TextEditingController(), b = TextEditingController(), c = TextEditingController();
  String r = '';

  void calc() {
    double x = double.parse(a.text), y = double.parse(b.text), z = double.parse(c.text);
    setState(() => r = 'Percentage: ${(x+y+z)/3}%');
  }

  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        TextField(controller: a, keyboardType: TextInputType.number),
        TextField(controller: b, keyboardType: TextInputType.number),
        TextField(controller: c, keyboardType: TextInputType.number),
        ElevatedButton(onPressed: calc, child: const Text('Calculate')),
        Text(r),
      ]),
    ),
  );
}