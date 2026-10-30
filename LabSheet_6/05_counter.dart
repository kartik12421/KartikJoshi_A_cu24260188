// Dependency: shared_preferences
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: CounterPage()));

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});
  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;
  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (mounted) setState(() => count = p.getInt('counter') ?? 0);
  }
  Future<void> _increment() async {
    final next = count + 1;
    final p = await SharedPreferences.getInstance();
    await p.setInt('counter', next);
    if (mounted) setState(() => count = next);
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Persistent Counter')),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text('Count: $count', style: Theme.of(context).textTheme.headlineMedium),
      ElevatedButton(onPressed: _increment, child: const Text('Increment')),
    ])),
  );
}
