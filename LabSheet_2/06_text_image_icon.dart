import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Scaffold(
    body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('My App', style: TextStyle(fontSize: 25)),
        Image(image: NetworkImage('https://picsum.photos/120'), height: 120),
        Icon(Icons.favorite, size: 40),
      ]),
    ),
  ),
));