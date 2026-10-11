import 'package:flutter/material.dart';

class Product {
  String name;
  int price;
  Product(this.name, this.price);
}

void main() => runApp(MaterialApp(home: Products()));

class Products extends StatelessWidget {
  final products = [
    Product("Laptop", 50000),
    Product("Mobile", 20000),
    Product("Mouse", 500),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(products[i].name),
          trailing: Text("₹${products[i].price}"),
        ),
      ),
    );
  }
}