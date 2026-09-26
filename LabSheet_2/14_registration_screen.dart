import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(title: Text('Registration')),
    body: Padding(
      padding: EdgeInsets.all(20),
      child: Column(children: [
        TextField(decoration: InputDecoration(labelText: 'Name')),
        TextField(decoration: InputDecoration(labelText: 'Email')),
        TextField(decoration: InputDecoration(labelText: 'Password'), obscureText: true),
        ElevatedButton(onPressed: () {}, child: Text('Register')),
      ]),
    ),
  ),
));