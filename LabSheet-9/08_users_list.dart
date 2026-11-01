// Question 8: Show API users with ListTile and CircleAvatar. Dependency: http.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: UsersPage()));

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});
  @override State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late Future<List<dynamic>> _users;
  @override void initState() { super.initState(); _users = _fetch(); }
  Future<List<dynamic>> _fetch() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (r.statusCode != 200) throw Exception('HTTP ${r.statusCode}');
    return jsonDecode(r.body) as List<dynamic>;
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Users')),
    body: FutureBuilder<List<dynamic>>(future: _users, builder: (context, s) {
      if (s.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
      if (s.hasError) return Center(child: Text('Error: ${s.error}'));
      return ListView(children: s.data!.map((u) => ListTile(
        leading: CircleAvatar(child: Text((u['name'] as String).characters.first)),
        title: Text(u['name'] as String), subtitle: Text(u['email'] as String),
      )).toList());
    }),
  );
}
