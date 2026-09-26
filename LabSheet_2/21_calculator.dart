import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Scaffold(
    body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('0', style: TextStyle(fontSize: 35)),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(onPressed: () {}, child: Text('7')),
          TextButton(onPressed: () {}, child: Text('8')),
          TextButton(onPressed: () {}, child: Text('9')),
          TextButton(onPressed: () {}, child: Text('+')),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(onPressed: () {}, child: Text('4')),
          TextButton(onPressed: () {}, child: Text('5')),
          TextButton(onPressed: () {}, child: Text('6')),
          TextButton(onPressed: () {}, child: Text('-')),
        ]),
      ]),
    ),
  ),
));