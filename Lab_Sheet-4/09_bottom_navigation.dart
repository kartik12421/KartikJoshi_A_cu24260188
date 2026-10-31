import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Main()));

class Main extends StatefulWidget {
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int i = 0;
  final pages = [
    Center(child: Text("Home")),
    Center(child: Text("Profile")),
    Center(child: Text("Settings"))
  ];

  Widget build(BuildContext c) => Scaffold(
    body: pages[i],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: i,
      onTap: (x) => setState(() => i = x),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    ),
  );
}
