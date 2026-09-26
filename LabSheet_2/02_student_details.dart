import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Scaffold(
    body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Name: Gulshan Kumar'),
        Text('Course: BCA'),
        Text('Semester: 5th'),
        Text('College: COER University'),
      ]),
    ),
  ),
));