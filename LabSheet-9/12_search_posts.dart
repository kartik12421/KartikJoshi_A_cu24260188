// Question 12: Filter fetched posts using a search TextField. Dependency: http.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: SearchPostsPage()));

class SearchPostsPage extends StatefulWidget {
  const SearchPostsPage({super.key});
  @override State<SearchPostsPage> createState() => _SearchPostsPageState();
}

class _SearchPostsPageState extends State<SearchPostsPage> {
  late Future<List<dynamic>> _posts;
  String _query = '';
  @override void initState() { super.initState(); _posts = _fetch(); }
  Future<List<dynamic>> _fetch() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (r.statusCode != 200) throw Exception('HTTP ${r.statusCode}');
    return jsonDecode(r.body) as List<dynamic>;
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Search Posts')),
    body: FutureBuilder<List<dynamic>>(future: _posts, builder: (context, s) {
      if (s.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
      if (s.hasError) return Center(child: Text('Error: ${s.error}'));
      final filtered = s.data!.where((p) => (p['title'] as String).toLowerCase().contains(_query.toLowerCase())).toList();
      return Column(children: [
        Padding(padding: const EdgeInsets.all(12), child: TextField(
          decoration: const InputDecoration(labelText: 'Search titles', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
          onChanged: (value) => setState(() => _query = value),
        )),
        Expanded(child: filtered.isEmpty ? const Center(child: Text('No matching posts')) : ListView.builder(
          itemCount: filtered.length, itemBuilder: (context, i) => ListTile(title: Text(filtered[i]['title'] as String)),
        )),
      ]);
    }),
  );
}
