import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("College")),
    body: Column(
      children: [
        Button("Home"),
        Button("Courses"),
        Button("Faculty"),
        Button("Contact"),
      ],
    ),
  );
}

class Button extends StatelessWidget {
  final String text;
  Button(this.text);

  Widget build(BuildContext c) =>
      ElevatedButton(child: Text(text), onPressed: () {});
}
