import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: RegisterApp()));

class RegisterApp extends StatefulWidget {
  const RegisterApp({super.key});
  State<RegisterApp> createState() => _RegisterAppState();
}

class _RegisterAppState extends State<RegisterApp> {
  String gender = 'Male', course = 'BCA';
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Registration')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const TextField(decoration: InputDecoration(labelText: 'Name')),
      const TextField(decoration: InputDecoration(labelText: 'Email')),
      const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Password')),
      RadioListTile(value: 'Male', groupValue: gender, title: const Text('Male'),
        onChanged: (v) => setState(() => gender = v!)),
      RadioListTile(value: 'Female', groupValue: gender, title: const Text('Female'),
        onChanged: (v) => setState(() => gender = v!)),
      DropdownButton<String>(
        value: course,
        items: ['BCA','BBA','MCA'].map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
        onChanged: (v) => setState(() => course = v!),
      ),
      ElevatedButton(onPressed: () {}, child: const Text('Register')),
    ]),
  );
}