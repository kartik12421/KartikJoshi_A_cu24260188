import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(title: Text('Login')),
    body: Padding(
      padding: EdgeInsets.all(20),
      child: Column(children: [
        Image(image: NetworkImage('https://picsum.photos/100'), height: 100),
        TextField(decoration: InputDecoration(labelText: 'Email')),
        TextField(decoration: InputDecoration(labelText: 'Password'), obscureText: true),
        ElevatedButton(onPressed: () {}, child: Text('Login')),
      ]),
    ),
  ),
));