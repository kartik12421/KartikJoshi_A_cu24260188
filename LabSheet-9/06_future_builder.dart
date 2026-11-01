// Question 6: Display API data using FutureBuilder. Dependency: http.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: FutureBuilderPage()));

class FutureBuilderPage extends StatefulWidget {
  const FutureBuilderPage({super.key});
  @override State<FutureBuilderPage> createState() => _FutureBuilderPageState();
}

class _FutureBuilderPageState extends State<FutureBuilderPage> {
  late Future<List<dynamic>> _posts;
  @override void initState() { super.initState(); _posts = _fetch(); }
  Future<List<dynamic>> _fetch() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=10'));
    if (r.statusCode != 200) throw Exception('HTTP ${r.statusCode}');
    return jsonDecode(r.body) as List<dynamic>;
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('FutureBuilder')),
    body: FutureBuilder<List<dynamic>>(future: _posts, builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
      if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
      return ListView(children: snapshot.data!.map((p) => ListTile(title: Text(p['title'] as String))).toList());
    }),
  );
}
