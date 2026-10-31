import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Login()));

class Login extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
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
  Widget build(BuildContext c) => Scaffold(
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
      Scaffold(body: Center(child: Text("Profile")));
}
