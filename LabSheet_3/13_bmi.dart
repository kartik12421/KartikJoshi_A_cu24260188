import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: BMIApp()));

class BMIApp extends StatefulWidget {
  const BMIApp({super.key});
  State<BMIApp> createState() => _BMIAppState();
}

class _BMIAppState extends State<BMIApp> {
  final h = TextEditingController(), w = TextEditingController();
  String r = '';

  void bmi() {
    double height = double.parse(h.text) / 100;
    double weight = double.parse(w.text);
    setState(() => r = 'BMI: ${(weight / (height * height)).toStringAsFixed(2)}');
  }

  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: h, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Height (cm)')),
      TextField(controller: w, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Weight (kg)')),
      ElevatedButton(onPressed: bmi, child: const Text('Calculate BMI')),
      Text(r),
    ])),
  );
}