import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Scaffold(
    appBar: AppBar(title: Text('COER University')),
    body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.school, size: 80),
        Text('COER University', style: TextStyle(fontSize: 25)),
        Text('Home   Courses   Contact'),
      ]),
    ),
  ),
));