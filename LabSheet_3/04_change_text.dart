import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: ChangeApp()));

class ChangeApp extends StatefulWidget {
  const ChangeApp({super.key});
  State<ChangeApp> createState() => _ChangeAppState();
}

class _ChangeAppState extends State<ChangeApp> {
  String text = 'Hello Flutter';

  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(text, style: const TextStyle(fontSize: 25)),
      ElevatedButton(
        onPressed: () => setState(() => text = 'Button Pressed!'),
        child: const Text('Click'),
      ),
    ])),
  );
}