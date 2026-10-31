import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Login()));

class Login extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Login")),
    body: Center(
      child: ElevatedButton(
        child: Text("Login"),
        onPressed: () => Navigator.push(
          c, MaterialPageRoute(builder: (_) => Home())),
      ),
    ),
  );
}

class Home extends StatelessWidget {
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text("Welcome Home")));
}
