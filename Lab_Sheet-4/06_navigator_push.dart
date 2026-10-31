import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    body: Center(
      child: ElevatedButton(
        child: Text("Open"),
        onPressed: () => Navigator.push(
          c, MaterialPageRoute(builder: (_) => Page2())),
      ),
    ),
  );
}

class Page2 extends StatelessWidget {
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text("New Screen")));
}
