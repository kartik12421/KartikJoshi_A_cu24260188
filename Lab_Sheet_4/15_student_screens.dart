import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Student")),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        B("Profile"),
        B("Attendance"),
        B("Result"),
      ],
    ),
  );

  Widget B(String text) => Builder(
    builder: (c) => ElevatedButton(
      child: Text(text),
      onPressed: () => Navigator.push(
        c, MaterialPageRoute(builder: (_) => Page(text))),
    ),
  );
}

class Page extends StatelessWidget {
  final String title;
  Page(this.title);

  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text(title)));
}
