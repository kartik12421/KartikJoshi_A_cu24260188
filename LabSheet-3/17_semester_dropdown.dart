import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: SemesterApp()));

class SemesterApp extends StatefulWidget {
  const SemesterApp({super.key});
  State<SemesterApp> createState() => _SemesterAppState();
}

class _SemesterAppState extends State<SemesterApp> {
  String sem = '1st';

  Widget build(BuildContext context) => Scaffold(
    body: Center(child: DropdownButton<String>(
      value: sem,
      items: ['1st','2nd','3rd','4th','5th','6th']
        .map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
      onChanged: (v) => setState(() => sem = v!),
    )),
  );
}