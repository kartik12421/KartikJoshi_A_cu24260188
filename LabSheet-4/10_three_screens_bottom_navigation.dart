import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Main()));

class Main extends StatefulWidget {
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int i = 0;

  Widget build(BuildContext c) {
    var pages = ["Home", "Profile", "Settings"];
    return Scaffold(
      body: Center(child: Text(pages[i], style: TextStyle(fontSize: 25))),
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
}
