import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    body: Center(
      child: ElevatedButton(
        child: Text("Show Name"),
        onPressed: () => Navigator.push(
          c, MaterialPageRoute(builder: (_) => Detail("Kartik"))),
      ),
    ),
  );
}

class Detail extends StatelessWidget {
  final String name;
  Detail(this.name);

  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text("Name: $name")));
}
