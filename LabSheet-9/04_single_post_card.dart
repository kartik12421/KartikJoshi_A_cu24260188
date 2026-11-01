// Question 4: Fetch a post and show its title and body in a Card. Dependency: http.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: SinglePostPage()));

class SinglePostPage extends StatefulWidget {
  const SinglePostPage({super.key});
  @override State<SinglePostPage> createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  late Future<Map<String, dynamic>> _post;
  @override void initState() { super.initState(); _post = _fetch(); }
  Future<Map<String, dynamic>> _fetch() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (r.statusCode != 200) throw Exception('HTTP ${r.statusCode}');
    return jsonDecode(r.body) as Map<String, dynamic>;
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Single Post')),
    body: Center(child: FutureBuilder<Map<String, dynamic>>(
      future: _post,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        final post = snapshot.data!;
        return Card(margin: const EdgeInsets.all(16), child: Padding(
          padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(post['title'] as String, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12), Text(post['body'] as String),
          ]),
        ));
      },
    )),
  );
}
