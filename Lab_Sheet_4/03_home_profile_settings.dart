import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Home")),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: Text("Profile"),
          onPressed: () => Navigator.push(
            c, MaterialPageRoute(builder: (_) => Profile())),
        ),
        ElevatedButton(
          child: Text("Settings"),
          onPressed: () => Navigator.push(
            c, MaterialPageRoute(builder: (_) => Settings())),
        ),
      ],
    ),
  );
}

class Profile extends StatelessWidget {
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text("Profile")));
}

class Settings extends StatelessWidget {
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text("Settings")));
}
