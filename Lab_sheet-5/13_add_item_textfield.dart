import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Items()));

class Items extends StatefulWidget {
  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  TextEditingController c = TextEditingController();
  List<String> items = [];

  void addItem() {
    if (c.text.isEmpty) return;
    setState(() {
      items.add(c.text);
      c.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Item")),
      body: Column(
        children: [
          TextField(controller: c),
          ElevatedButton(onPressed: addItem, child: Text("Add")),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) => ListTile(title: Text(items[i])),
            ),
          ),
        ],
      ),
    );
  }
}