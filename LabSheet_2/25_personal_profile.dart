import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(title: Text('My Profile')),
    body: Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            CircleAvatar(radius: 45,
              backgroundImage: NetworkImage('https://picsum.photos/100')),
            Text('Gulshan Kumar', style: TextStyle(fontSize: 25)),
            Text('BCA Student'),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.email), Text(' gulshan@example.com'),
            ]),
            ElevatedButton(onPressed: () {}, child: Text('Contact')),
          ]),
        ),
      ),
    ),
  ),
));