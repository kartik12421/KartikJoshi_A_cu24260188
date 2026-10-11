import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: DeleteList()));

class DeleteList extends StatefulWidget {
  @override
  State<DeleteList> createState() => _DeleteListState();
}

class _DeleteListState extends State<DeleteList> {
  List<String> items = ["Apple", "Banana", "Mango", "Orange"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delete Item")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(items[i]),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => setState(() => items.removeAt(i)),
          ),
        ),
      ),
    );
  }
}