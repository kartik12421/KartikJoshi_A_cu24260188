import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: AgreeApp()));

class AgreeApp extends StatefulWidget {
  const AgreeApp({super.key});
  State<AgreeApp> createState() => _AgreeAppState();
}

class _AgreeAppState extends State<AgreeApp> {
  bool agree = false;

  Widget build(BuildContext context) => Scaffold(
    body: Center(child: CheckboxListTile(
      value: agree,
      title: const Text('I agree to Terms and Conditions'),
      onChanged: (v) => setState(() => agree = v!),
    )),
  );
}