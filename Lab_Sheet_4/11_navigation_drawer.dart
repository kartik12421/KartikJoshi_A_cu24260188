import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("College App")),
    drawer: Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text("Menu")),
          ListTile(title: Text("Home")),
          ListTile(title: Text("Profile")),
          ListTile(title: Text("About")),
          ListTile(title: Text("Settings")),
        ],
      ),
    ),
    body: Center(child: Text("Home Screen")),
  );
}
