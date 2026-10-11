import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: SwipeList()));

class SwipeList extends StatefulWidget {
  @override
  State<SwipeList> createState() => _SwipeListState();
}

class _SwipeListState extends State<SwipeList> {
  List<String> items = ["Apple", "Banana", "Mango", "Orange"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Swipe to Delete")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) => Dismissible(
          key: Key(items[i]),
          onDismissed: (_) => setState(() => items.removeAt(i)),
          child: ListTile(title: Text(items[i])),
        ),
      ),
    );
  }
}