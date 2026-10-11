import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: SearchNames()));

class SearchNames extends StatefulWidget {
  @override
  State<SearchNames> createState() => _SearchNamesState();
}

class _SearchNamesState extends State<SearchNames> {
  List<String> names = ["Kartik", "Rahul", "Aman", "Ravi", "Priya"];
  String search = "";

  @override
  Widget build(BuildContext context) {
    var result = names
        .where((n) => n.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: "Search name"),
            onChanged: (value) => setState(() => search = value),
          ),
          Expanded(
            child: ListView(
              children: result.map((n) => ListTile(title: Text(n))).toList(),
            ),
          ),
        ],
      ),
    );
  }
}