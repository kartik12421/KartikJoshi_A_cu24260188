import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Main()));

class Main extends StatefulWidget {
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int i = 0;
  var pages = ["Home", "Courses", "Contact"];

  Widget build(BuildContext c) => Scaffold(
    body: Center(child: Text(pages[i])),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: i,
      onTap: (x) => setState(() => i = x),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
        BottomNavigationBarItem(icon: Icon(Icons.phone), label: "Contact"),
      ],
    ),
  );
}
