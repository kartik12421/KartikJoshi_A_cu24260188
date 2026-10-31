import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    body: Center(
      child: ElevatedButton(
        child: Text("Details"),
        onPressed: () => Navigator.push(
          c, MaterialPageRoute(builder: (_) => Detail())),
      ),
    ),
  );
}

class Detail extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    body: Center(
      child: ElevatedButton(
        child: Text("Back"),
        onPressed: () => Navigator.pop(c),
      ),
    ),
  );
}
