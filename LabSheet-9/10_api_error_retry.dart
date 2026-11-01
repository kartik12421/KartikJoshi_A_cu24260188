// Question 10: Handle request/status errors and provide Retry. Dependency: http.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: RetryPage()));

class RetryPage extends StatefulWidget {
  const RetryPage({super.key});
  @override State<RetryPage> createState() => _RetryPageState();
}

class _RetryPageState extends State<RetryPage> {
  String? _title;
  String? _error;
  bool _loading = false;
  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final r = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1')).timeout(const Duration(seconds: 10));
      if (r.statusCode != 200) throw Exception('Server returned status ${r.statusCode}');
      final json = jsonDecode(r.body) as Map<String, dynamic>;
      if (mounted) setState(() => _title = json['title'] as String);
    } catch (e) { if (mounted) setState(() => _error = 'Could not load data. Check your connection. ($e)'); }
    finally { if (mounted) setState(() => _loading = false); }
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('API Error Handling')),
    body: Center(child: _loading ? const CircularProgressIndicator() : _error != null
      ? Column(mainAxisSize: MainAxisSize.min, children: [Text(_error!, textAlign: TextAlign.center), const SizedBox(height: 12), ElevatedButton(onPressed: _load, child: const Text('Retry'))])
      : Column(mainAxisSize: MainAxisSize.min, children: [Text(_title ?? 'Press Load to fetch data'), ElevatedButton(onPressed: _load, child: const Text('Load'))])),
  );
}
