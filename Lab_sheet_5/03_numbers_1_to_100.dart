import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Scaffold(
  appBar: AppBar(title: Text("Numbers")),
  body: ListView.builder(
    itemCount: 100,
    itemBuilder: (context, index) {
      return ListTile(title: Text("${index + 1}"));
    },
  ),
)));