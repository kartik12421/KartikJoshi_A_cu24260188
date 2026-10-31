import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Scaffold(
  appBar: AppBar(title: Text("Horizontal List")),
  body: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 5,
    itemBuilder: (context, i) => Container(
      width: 120,
      margin: EdgeInsets.all(10),
      color: Colors.blue,
      child: Center(child: Text("Item ${i + 1}")),
    ),
  ),
)));