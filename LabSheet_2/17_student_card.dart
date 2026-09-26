import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Scaffold(
    body: Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('Name: Gulshan Kumar'),
            Text('Roll No: 101'),
            Text('Course: BCA'),
            Text('Semester: 5th'),
          ]),
        ),
      ),
    ),
  ),
));