import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Scaffold(
    body: Center(
      child: Container(
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.all(20),
        color: Colors.blue,
        child: Text('Padding and Margin',
          style: TextStyle(color: Colors.white)),
      ),
    ),
  ),
));