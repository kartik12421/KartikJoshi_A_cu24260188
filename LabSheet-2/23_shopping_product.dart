import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    body: Center(
      child: Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image(image: NetworkImage('https://picsum.photos/200'), height: 180),
          Text('Smart Watch', style: TextStyle(fontSize: 24)),
          Text('₹2,999'),
          Icon(Icons.star, color: Colors.amber),
          ElevatedButton(onPressed: () {}, child: Text('Buy Now')),
        ]),
      ),
    ),
  ),
));