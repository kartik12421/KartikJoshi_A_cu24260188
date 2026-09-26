import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Scaffold(
    body: Column(children: [
      Card(child: ListTile(title: Text('Laptop'), subtitle: Text('₹50,000'))),
      Card(child: ListTile(title: Text('Phone'), subtitle: Text('₹20,000'))),
      Card(child: ListTile(title: Text('Headphones'), subtitle: Text('₹2,000'))),
    ]),
  ),
));