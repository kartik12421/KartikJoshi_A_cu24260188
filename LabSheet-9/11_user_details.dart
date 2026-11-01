// Question 11: Select a user to open a screen with complete details. Dependency: http.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: UserListPage()));

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});
  @override State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<dynamic>> _users;
  @override void initState() { super.initState(); _users = _fetch(); }
  Future<List<dynamic>> _fetch() async {
    final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (r.statusCode != 200) throw Exception('HTTP ${r.statusCode}');
    return jsonDecode(r.body) as List<dynamic>;
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('User Directory')),
    body: FutureBuilder<List<dynamic>>(future: _users, builder: (context, s) {
      if (s.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
      if (s.hasError) return Center(child: Text('Error: ${s.error}'));
      return ListView(children: s.data!.map((u) => ListTile(
        leading: CircleAvatar(child: Text((u['name'] as String).characters.first)),
        title: Text(u['name'] as String), subtitle: Text(u['email'] as String),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserDetailPage(user: u as Map<String, dynamic>))),
      )).toList());
    }),
  );
}

class UserDetailPage extends StatelessWidget {
  final Map<String, dynamic> user;
  const UserDetailPage({super.key, required this.user});
  @override Widget build(BuildContext context) {
    final address = user['address'] as Map<String, dynamic>;
    final company = user['company'] as Map<String, dynamic>;
    final geo = address['geo'] as Map<String, dynamic>;
    return Scaffold(appBar: AppBar(title: Text(user['name'] as String)), body: ListView(padding: const EdgeInsets.all(16), children: [
      _detail('Username', user['username']), _detail('Email', user['email']), _detail('Phone', user['phone']),
      _detail('Website', user['website']), _detail('Company', company['name']), _detail('Catch phrase', company['catchPhrase']),
      _detail('Address', '${address['suite']}, ${address['street']}, ${address['city']} ${address['zipcode']}'),
      _detail('Coordinates', '${geo['lat']}, ${geo['lng']}'),
    ]));
  }
  Widget _detail(String label, dynamic value) => ListTile(title: Text(label), subtitle: Text('$value'));
}
