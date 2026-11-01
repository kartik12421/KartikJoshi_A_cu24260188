import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  final name = TextEditingController();

  Widget build(BuildContext c) => Scaffold(
    body: Column(
      children: [
        TextField(controller: name),
        ElevatedButton(
          child: Text("Submit"),
          onPressed: () => Navigator.push(
            c, MaterialPageRoute(builder: (_) => Detail(name.text))),
        )
      ],
    ),
  );
}

class Detail extends StatelessWidget {
  final String name;
  Detail(this.name);

  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text("Hello $name")));
}
