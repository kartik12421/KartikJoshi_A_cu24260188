import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Scaffold(
    body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Dehradun', style: TextStyle(fontSize: 25)),
        Icon(Icons.wb_sunny, size: 80),
        Text('28°C', style: TextStyle(fontSize: 40)),
        Text('Sunny'),
      ]),
    ),
  ),
));