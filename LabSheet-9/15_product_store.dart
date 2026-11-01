// Question 15: Product grid, detail screen, loading, and error handling. Dependency: http.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  const Product({required this.id, required this.title, required this.description, required this.price, required this.image});
  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as int, title: json['title'] as String,
    description: json['description'] as String,
    price: (json['price'] as num).toDouble(), image: json['image'] as String,
  );
}

void main() => runApp(const MaterialApp(home: ProductStorePage()));

class ProductStorePage extends StatefulWidget {
  const ProductStorePage({super.key});
  @override State<ProductStorePage> createState() => _ProductStorePageState();
}

class _ProductStorePageState extends State<ProductStorePage> {
  late Future<List<Product>> _products;
  @override void initState() { super.initState(); _products = _fetch(); }
  Future<List<Product>> _fetch() async {
    final r = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (r.statusCode != 200) throw Exception('HTTP ${r.statusCode}');
    return (jsonDecode(r.body) as List<dynamic>)
      .map((p) => Product.fromJson(p as Map<String, dynamic>)).toList();
  }
  void _retry() => setState(() => _products = _fetch());
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Product Store')),
    body: FutureBuilder<List<Product>>(future: _products, builder: (context, s) {
      if (s.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
      if (s.hasError) return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Could not load products: ${s.error}', textAlign: TextAlign.center),
        const SizedBox(height: 12), ElevatedButton(onPressed: _retry, child: const Text('Retry')),
      ]));
      final products = s.data!;
      return GridView.builder(padding: const EdgeInsets.all(10), itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: .68, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, i) {
          final product = products[i];
          return Card(clipBehavior: Clip.antiAlias, child: InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(product: product))),
            child: Padding(padding: const EdgeInsets.all(10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: Center(child: Image.network(product.image, fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 48)))),
              const SizedBox(height: 8), Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4), Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
            ])),
          ));
        },
      );
    }),
  );
}

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Product Details')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      SizedBox(height: 280, child: Image.network(product.image, fit: BoxFit.contain,
        loadingBuilder: (context, child, progress) => progress == null ? child : const Center(child: CircularProgressIndicator()),
        errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image, size: 64)))),
      const SizedBox(height: 20), Text(product.title, style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 8), Text('\$${product.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16), Text(product.description),
    ]),
  );
}
