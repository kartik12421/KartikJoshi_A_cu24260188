// Question 13: Reload API data with RefreshIndicator. Dependency: http.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: RefreshPostsPage()));

class RefreshPostsPage extends StatefulWidget {
  const RefreshPostsPage({super.key});
  @override State<RefreshPostsPage> createState() => _RefreshPostsPageState();
}

class _RefreshPostsPageState extends State<RefreshPostsPage> {
  List<dynamic> _posts = [];
  bool _loading = true;
  String? _error;
  @override void initState() { super.initState(); _load(); }
  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=20'));
      if (r.statusCode != 200) throw Exception('HTTP ${r.statusCode}');
      final posts = jsonDecode(r.body) as List<dynamic>;
      if (mounted) setState(() => _posts = posts);
    } catch (e) { if (mounted) setState(() => _error = '$e'); }
    finally { if (mounted) setState(() => _loading = false); }
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Pull to Refresh')),
    body: _loading && _posts.isEmpty ? const Center(child: CircularProgressIndicator()) : _error != null && _posts.isEmpty
      ? Center(child: Text('Error: $_error'))
      : RefreshIndicator(onRefresh: _load, child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(), itemCount: _posts.length,
        itemBuilder: (context, i) => ListTile(title: Text(_posts[i]['title'] as String)),
      )),
  );
}
