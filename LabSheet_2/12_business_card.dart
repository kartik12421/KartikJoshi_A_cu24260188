import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Scaffold(
    body: Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            CircleAvatar(backgroundImage: NetworkImage('https://picsum.photos/100')),
            Text('Kartik Joshi', style: TextStyle(fontSize: 24)),
            Text('Phone: 9876543210'),
            Text('Email: kj@example.com'),
          ]),
        ),
      ),
    ),
  ),
));