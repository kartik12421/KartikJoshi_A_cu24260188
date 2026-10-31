// Lab Sheet 8 - Question 12: Validate credentials against SQLite and navigate on success.
// Dependencies: Flutter SDK, sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage()));

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Database? db;
  final username = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override void initState() { super.initState(); _open(); }
  Future<void> _open() async {
    final file = p.join(await getDatabasesPath(), 'login_users.db');
    db = await openDatabase(file, version: 1, onCreate: (database, version) async {
      await database.execute('CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT UNIQUE NOT NULL, password TEXT NOT NULL)');
      // Demo credentials make the example usable immediately. Change these for your lab run.
      await database.insert('users', {'username': 'student', 'password': 'pass123'});
    });
    if (mounted) setState(() {});
  }
  Future<void> _login() async {
    if (!formKey.currentState!.validate()) return;
    final matches = await db!.query('users', where: 'username = ? AND password = ?', whereArgs: [username.text.trim(), password.text]);
    if (!mounted) return;
    if (matches.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid username or password')));
      return;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(name: username.text.trim())));
  }
  @override void dispose() { username.dispose(); password.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('SQLite Login')),
    body: db == null ? const Center(child: CircularProgressIndicator()) : Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Form(
      key: formKey,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextFormField(controller: username, decoration: const InputDecoration(labelText: 'Username'), validator: (v) => (v ?? '').trim().isEmpty ? 'Enter username' : null),
        TextFormField(controller: password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true, validator: (v) => (v ?? '').isEmpty ? 'Enter password' : null),
        const SizedBox(height: 20),
        FilledButton(onPressed: _login, child: const Text('Log in')),
        const SizedBox(height: 12),
        const Text('Demo login: student / pass123'),
      ]),
    ))),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.name});
  final String name;
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Home')),
    body: Center(child: Text('Welcome, $name!', style: Theme.of(context).textTheme.headlineSmall)),
  );
}
