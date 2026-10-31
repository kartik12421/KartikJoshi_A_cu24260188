// Dependency: shared_preferences
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: FirstLaunchPage()));

class FirstLaunchPage extends StatefulWidget {
  const FirstLaunchPage({super.key});
  @override
  State<FirstLaunchPage> createState() => _FirstLaunchPageState();
}

class _FirstLaunchPageState extends State<FirstLaunchPage> {
  bool? firstLaunch;
  @override
  void initState() { super.initState(); _check(); }
  Future<void> _check() async {
    final p = await SharedPreferences.getInstance(); final first = !(p.getBool('hasLaunched') ?? false);
    if (first) await p.setBool('hasLaunched', true);
    if (mounted) setState(() => firstLaunch = first);
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Launch Greeting')),
    body: Center(child: firstLaunch == null ? const CircularProgressIndicator() : Text(firstLaunch! ? 'Welcome! This is your first launch.' : 'Welcome back!')));
}
