import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Scaffold(
  appBar: AppBar(title: Text("Icon Grid")),
  body: GridView.count(
    crossAxisCount: 3,
    children: [
      Icon(Icons.home, size: 50),
      Icon(Icons.person, size: 50),
      Icon(Icons.email, size: 50),
      Icon(Icons.phone, size: 50),
      Icon(Icons.settings, size: 50),
      Icon(Icons.camera, size: 50),
    ],
  ),
)));