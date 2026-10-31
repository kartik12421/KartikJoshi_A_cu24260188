import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Counter()));

class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int n = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$n", style: TextStyle(fontSize: 40)),
            ElevatedButton(
              onPressed: () => setState(() => n++),
              child: Text("Increment"),
            ),
            ElevatedButton(
              onPressed: () => setState(() => n--),
              child: Text("Decrement"),
            ),
            ElevatedButton(
              onPressed: () => setState(() => n = 0),
              child: Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}