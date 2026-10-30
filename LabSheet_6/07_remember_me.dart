// Dependency: shared_preferences
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: LoginPage()));

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool remember = false;
  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() { remember = p.getBool('rememberMe') ?? false; if (remember) username.text = p.getString('loginName') ?? ''; });
  }
  Future<void> _login() async {
    final p = await SharedPreferences.getInstance();
    await p.setBool('rememberMe', remember);
    if (remember) { await p.setString('loginName', username.text.trim()); } else { await p.remove('loginName'); }
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login details submitted')));
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Login')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: username, decoration: const InputDecoration(labelText: 'Username')),
      TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
      CheckboxListTile(title: const Text('Remember me'), value: remember, onChanged: (v) => setState(() => remember = v ?? false)),
      ElevatedButton(onPressed: _login, child: const Text('Login')),
    ])));
  @override
  void dispose() { username.dispose(); password.dispose(); super.dispose(); }
}
