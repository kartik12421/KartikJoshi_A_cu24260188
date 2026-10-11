import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Shop()));

class Shop extends StatefulWidget {
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  int i = 0;
  var pages = ["Home", "Products", "Cart", "Profile"];

  Widget build(BuildContext c) => Scaffold(
    body: Center(child: Text(pages[i])),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: i,
      onTap: (x) => setState(() => i = x),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Products"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    ),
  );
}
