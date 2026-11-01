// Question 7: Fetch posts and display titles with ListView.builder. Dependency: http.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: PostsPage()));

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});
  @override State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Future<List<dynamic>> _posts;
  @override void initState() { super.initState(); _posts = _fetch(); }
  Future<List<dynamic>> _fetch() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (r.statusCode != 200) throw Exception('HTTP ${r.statusCode}');
    return jsonDecode(r.body) as List<dynamic>;
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Post Titles')),
    body: FutureBuilder<List<dynamic>>(future: _posts, builder: (context, s) {
      if (s.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
      if (s.hasError) return Center(child: Text('Error: ${s.error}'));
      final posts = s.data!;
      return ListView.builder(itemCount: posts.length, itemBuilder: (context, i) => ListTile(
        leading: CircleAvatar(child: Text('${posts[i]['id']}')),
        title: Text(posts[i]['title'] as String),
      ));
    }),
  );
}
