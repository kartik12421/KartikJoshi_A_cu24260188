import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: DepartmentApp()));

class DepartmentApp extends StatefulWidget {
  const DepartmentApp({super.key});
  State<DepartmentApp> createState() => _DepartmentAppState();
}

class _DepartmentAppState extends State<DepartmentApp> {
  String dept = 'Computer Science';

  Widget build(BuildContext context) => Scaffold(
    body: Center(child: DropdownButton<String>(
      value: dept,
      items: ['Computer Science','Management','Commerce']
        .map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
      onChanged: (v) => setState(() => dept = v!),
    )),
  );
}