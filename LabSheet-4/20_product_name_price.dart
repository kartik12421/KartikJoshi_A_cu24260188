import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    body: Center(
      child: ElevatedButton(
        child: Text("Product"),
        onPressed: () => Navigator.push(
          c,
          MaterialPageRoute(builder: (_) => Detail("Laptop", 50000)),
        ),
      ),
    ),
  );
}

class Detail extends StatelessWidget {
  final String name;
  final int price;
  Detail(this.name, this.price);

  Widget build(BuildContext c) =>
      Scaffold(body: Center(child: Text("$name\n₹$price")));
}
