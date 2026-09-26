import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Scaffold(
    body: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.home, size: 40),
        Icon(Icons.person, size: 40),
        Icon(Icons.settings, size: 40),
      ],
    ),
  ),
));