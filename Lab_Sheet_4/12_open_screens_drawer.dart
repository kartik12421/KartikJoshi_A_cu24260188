import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Home")),
    drawer: Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text("Profile"),
            onTap: () => Navigator.push(
              c, MaterialPageRoute(builder: (_) => Profile())),
          ),
          ListTile(
            title: Text("About"),
            onTap: () => Navigator.push(
              c, MaterialPageRoute(builder: (_) => About())),
          ),
        ],
      ),
    ),
    body: Center(child: Text("Home")),
  );
}

class Profile extends StatelessWidget {
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text("Profile")));
}

class About extends StatelessWidget {
  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text("About")));
}
