import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: First()));

class First extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    body: Center(
      child: ElevatedButton(
        child: Text("Next"),
        onPressed: () => Navigator.push(
          c, MaterialPageRoute(builder: (_) => Second())),
      ),
    ),
  );
}

class Second extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    body: Center(
      child: ElevatedButton(
        child: Text("Back"),
        onPressed: () => Navigator.pop(c),
      ),
    ),
  );
}
