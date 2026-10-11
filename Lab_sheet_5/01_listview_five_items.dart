import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Scaffold(
  appBar: AppBar(title: Text("Five Items")),
  body: ListView(
    children: [
      ListTile(title: Text("Apple")),
      ListTile(title: Text("Banana")),
      ListTile(title: Text("Mango")),
      ListTile(title: Text("Orange")),
      ListTile(title: Text("Grapes")),
    ],
  ),
)));