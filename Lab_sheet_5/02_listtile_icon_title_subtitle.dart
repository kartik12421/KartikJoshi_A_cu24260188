import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Scaffold(
  appBar: AppBar(title: Text("ListTile")),
  body: ListView(
    children: [
      ListTile(
        leading: Icon(Icons.person),
        title: Text("Kartik"),
        subtitle: Text("BCA Student"),
      ),
      ListTile(
        leading: Icon(Icons.email),
        title: Text("Email"),
        subtitle: Text("kj@gmail.com"),
      ),
    ],
  ),
)));