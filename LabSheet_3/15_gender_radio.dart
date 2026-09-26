import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: GenderApp()));

class GenderApp extends StatefulWidget {
  const GenderApp({super.key});
  State<GenderApp> createState() => _GenderAppState();
}

class _GenderAppState extends State<GenderApp> {
  String gender = 'Male';

  Widget build(BuildContext context) => Scaffold(
    body: Column(children: ['Male', 'Female']
      .map((x) => RadioListTile<String>(
        value: x, groupValue: gender,
        title: Text(x),
        onChanged: (v) => setState(() => gender = v!),
      )).toList()),
  );
}