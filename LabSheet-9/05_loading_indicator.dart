// Question 5: Show a CircularProgressIndicator while fetching data. Dependency: http.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: LoadingPage()));

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});
  @override State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  String? _title;
  String? _error;
  bool _loading = false;
  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if (r.statusCode != 200) throw Exception('HTTP ${r.statusCode}');
      final data = jsonDecode(r.body) as Map<String, dynamic>;
      if (mounted) setState(() => _title = data['title'] as String);
    } catch (e) { if (mounted) setState(() => _error = '$e'); }
    finally { if (mounted) setState(() => _loading = false); }
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Loading Indicator')),
    body: Center(child: _loading ? const CircularProgressIndicator()
      : _error != null ? Text('Error: $_error')
      : Column(mainAxisSize: MainAxisSize.min, children: [Text(_title ?? 'No data loaded'), ElevatedButton(onPressed: _load, child: const Text('Load data'))])),
  );
}
