import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: AreaApp()));

class AreaApp extends StatefulWidget {
  const AreaApp({super.key});
  State<AreaApp> createState() => _AreaAppState();
}

class _AreaAppState extends State<AreaApp> {
  final l = TextEditingController(), w = TextEditingController();
  String r = '';

  void area() => setState(() =>
      r = 'Area: ${double.parse(l.text) * double.parse(w.text)}');

  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: l, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Length')),
      TextField(controller: w, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Width')),
      ElevatedButton(onPressed: area, child: const Text('Area')),
      Text(r),
    ])),
  );
}