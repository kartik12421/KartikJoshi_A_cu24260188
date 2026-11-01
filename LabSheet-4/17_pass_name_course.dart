import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    body: Center(
      child: ElevatedButton(
        child: Text("View"),
        onPressed: () => Navigator.push(
          c,
          MaterialPageRoute(builder: (_) => Detail("Kartik", "BCA")),
        ),
      ),
    ),
  );
}

class Detail extends StatelessWidget {
  final String name, course;
  Detail(this.name, this.course);

  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text("$name\n$course")));
}
