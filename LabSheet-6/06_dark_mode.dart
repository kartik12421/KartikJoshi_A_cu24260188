// Dependency: shared_preferences
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const DarkModeApp());

class DarkModeApp extends StatefulWidget {
  const DarkModeApp({super.key});
  @override
  State<DarkModeApp> createState() => _DarkModeAppState();
}

class _DarkModeAppState extends State<DarkModeApp> {
  bool dark = false;
  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (mounted) setState(() => dark = p.getBool('darkMode') ?? false);
  }
  Future<void> _setDark(bool value) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool('darkMode', value);
    if (mounted) setState(() => dark = value);
  }
  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
    darkTheme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.dark)),
    themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    home: Scaffold(appBar: AppBar(title: const Text('Dark Mode Setting')),
      body: SwitchListTile(title: const Text('Dark mode'), value: dark, onChanged: _setDark)),
  );
}
