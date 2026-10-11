import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Menu")),
    drawer: Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text("College")),
          ListTile(icon: Icon(Icons.home), title: Text("Home")),
          ListTile(icon: Icon(Icons.book), title: Text("Courses")),
          ListTile(icon: Icon(Icons.person), title: Text("Profile")),
          ListTile(icon: Icon(Icons.settings), title: Text("Settings")),
        ],
      ),
    ),
    body: Center(child: Text("Home")),
  );
}
