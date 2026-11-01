import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    body: Center(
      child: ElevatedButton(
        child: Text("Calculate"),
        onPressed: () => Navigator.push(
          c, MaterialPageRoute(builder: (_) => Detail(10, 20))),
      ),
    ),
  );
}

class Detail extends StatelessWidget {
  final int a, b;
  Detail(this.a, this.b);

  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text("Sum = ${a + b}")));
}
