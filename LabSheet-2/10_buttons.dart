import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    body: Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton(onPressed: () {}, child: Text('Submit')),
        ElevatedButton(onPressed: () {}, child: Text('Reset')),
        ElevatedButton(onPressed: () {}, child: Text('Cancel')),
      ]),
    ),
  ),
));