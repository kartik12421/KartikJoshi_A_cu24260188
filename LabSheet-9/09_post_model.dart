// Question 9: Convert API JSON into model objects and display them. Dependency: http.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String title;
  final String body;
  const Post({required this.id, required this.title, required this.body});
  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'] as int, title: json['title'] as String, body: json['body'] as String,
  );
}

void main() => runApp(const MaterialApp(home: PostModelPage()));

class PostModelPage extends StatefulWidget {
  const PostModelPage({super.key});
  @override State<PostModelPage> createState() => _PostModelPageState();
}

class _PostModelPageState extends State<PostModelPage> {
  late Future<List<Post>> _posts;
  @override void initState() { super.initState(); _posts = _fetch(); }
  Future<List<Post>> _fetch() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=20'));
    if (r.statusCode != 200) throw Exception('HTTP ${r.statusCode}');
    return (jsonDecode(r.body) as List<dynamic>)
        .map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Posts as Objects')),
    body: FutureBuilder<List<Post>>(future: _posts, builder: (context, s) {
      if (s.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
      if (s.hasError) return Center(child: Text('Error: ${s.error}'));
      return ListView.builder(itemCount: s.data!.length, itemBuilder: (context, i) {
        final post = s.data![i];
        return ListTile(title: Text(post.title), subtitle: Text(post.body), leading: CircleAvatar(child: Text('${post.id}')));
      });
    }),
  );
}
