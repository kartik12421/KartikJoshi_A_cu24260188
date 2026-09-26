import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Scaffold(
    body: Column(children: [
      Expanded(child: Center(child: Text('Center'))),
      Expanded(child: Align(
        alignment: Alignment.bottomRight,
        child: Text('Bottom Right'),
      )),
    ]),
  ),
));