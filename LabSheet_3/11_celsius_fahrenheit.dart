import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: TempApp()));

class TempApp extends StatefulWidget {
  const TempApp({super.key});
  State<TempApp> createState() => _TempAppState();
}

class _TempAppState extends State<TempApp> {
  final c = TextEditingController();
  String r = '';

  void convert() => setState(() => r =
      'Fahrenheit: ${(double.parse(c.text) * 9 / 5) + 32}');

  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: c, keyboardType: TextInputType.number),
      ElevatedButton(onPressed: convert, child: const Text('Convert')),
      Text(r),
    ])),
  );
}