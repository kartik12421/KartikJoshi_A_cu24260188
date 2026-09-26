import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: InputsApp()));

class InputsApp extends StatefulWidget {
  const InputsApp({super.key});
  State<InputsApp> createState() => _InputsAppState();
}

class _InputsAppState extends State<InputsApp> {
  bool agree = false, on = false;
  String gender = 'Male', course = 'BCA';

  Widget build(BuildContext context) => Scaffold(
    body: ListView(padding: const EdgeInsets.all(15), children: [
      CheckboxListTile(value: agree, title: const Text('Agree'),
        onChanged: (v) => setState(() => agree = v!)),
      RadioListTile(value: 'Male', groupValue: gender, title: const Text('Male'),
        onChanged: (v) => setState(() => gender = v!)),
      RadioListTile(value: 'Female', groupValue: gender, title: const Text('Female'),
        onChanged: (v) => setState(() => gender = v!)),
      DropdownButton<String>(
        value: course,
        items: ['BCA','BBA','MCA'].map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
        onChanged: (v) => setState(() => course = v!),
      ),
      SwitchListTile(value: on, title: const Text('Setting'),
        onChanged: (v) => setState(() => on = v)),
    ]),
  );
}