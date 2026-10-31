import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(title: Text('Food Menu')),
    body: ListView(children: [
      ListTile(
        leading: Icon(Icons.local_pizza),
        title: Text('Pizza'),
        trailing: ElevatedButton(onPressed: () {}, child: Text('Order')),
      ),
      ListTile(
        leading: Icon(Icons.fastfood),
        title: Text('Burger'),
        trailing: ElevatedButton(onPressed: () {}, child: Text('Order')),
      ),
    ]),
  ),
));