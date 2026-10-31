import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Scaffold(
  appBar: AppBar(title: Text("Color Grid")),
  body: GridView.builder(
    itemCount: 9,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
    ),
    itemBuilder: (context, i) => Container(
      margin: EdgeInsets.all(5),
      color: Colors.primaries[i],
      child: Center(child: Text("${i + 1}")),
    ),
  ),
)));