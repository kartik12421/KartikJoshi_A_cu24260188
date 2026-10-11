import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Counter()));

class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter")),
      body: Center(child: Text("$count", style: TextStyle(fontSize: 40))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => count++),
        child: Icon(Icons.add),
      ),
    );
  }
}