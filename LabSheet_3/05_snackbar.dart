import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SnackApp()));

class SnackApp extends StatelessWidget {
  const SnackApp({super.key});

  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: ElevatedButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hello!')),
        ),
        child: const Text('Show Message'),
      ),
    ),
  );
}