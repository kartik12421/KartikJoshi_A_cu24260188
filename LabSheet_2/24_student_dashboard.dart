import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(title: Text('Student Dashboard')),
    body: Column(children: [
      ListTile(
        leading: CircleAvatar(child: Icon(Icons.person)),
        title: Text('Gulshan Kumar'),
        subtitle: Text('BCA Student'),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Card(child: Padding(padding: EdgeInsets.all(20), child: Text('Courses'))),
        Card(child: Padding(padding: EdgeInsets.all(20), child: Text('Marks'))),
      ]),
    ]),
  ),
));