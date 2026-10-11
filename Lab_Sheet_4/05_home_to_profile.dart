import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Home")),
    body: Center(
      child: ElevatedButton(
        child: Text("Profile"),
        onPressed: () => Navigator.push(
          c, MaterialPageRoute(builder: (_) => Profile())),
      ),
    ),
  );
}

class Profile extends StatelessWidget {
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text("Student Profile")));
}
