import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: LoginApp()));

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final u = TextEditingController(), p = TextEditingController();
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Login')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: u, decoration: const InputDecoration(labelText: 'Username')),
      TextField(controller: p, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
      Row(children: [
        ElevatedButton(onPressed: () {}, child: const Text('Login')),
        const SizedBox(width: 10),
        ElevatedButton(onPressed: () { u.clear(); p.clear(); }, child: const Text('Reset')),
      ]),
    ])),
  );
}