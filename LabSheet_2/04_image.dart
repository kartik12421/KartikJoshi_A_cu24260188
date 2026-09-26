import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Scaffold(
    body: Center(
      child: Image(image: NetworkImage('https://picsum.photos/200')),
    ),
  ),
));