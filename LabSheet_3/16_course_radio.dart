import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: CourseApp()));

class CourseApp extends StatefulWidget {
  const CourseApp({super.key});
  State<CourseApp> createState() => _CourseAppState();
}

class _CourseAppState extends State<CourseApp> {
  String course = 'BCA';

  Widget build(BuildContext context) => Scaffold(
    body: Column(children: ['BCA', 'BBA', 'MCA']
      .map((x) => RadioListTile<String>(
        value: x, groupValue: course,
        title: Text(x),
        onChanged: (v) => setState(() => course = v!),
      )).toList()),
  );
}