// Question 3: Fetch and display a raw API response. Dependency: http.
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: RawApiPage()));

class RawApiPage extends StatefulWidget {
  const RawApiPage({super.key});
  @override State<RawApiPage> createState() => _RawApiPageState();
}

class _RawApiPageState extends State<RawApiPage> {
  String _body = 'Tap Fetch to load data.';
  bool _loading = false;
  Future<void> _fetch() async {
    setState(() { _loading = true; _body = ''; });
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if (response.statusCode != 200) throw Exception('HTTP ${response.statusCode}');
      if (mounted) setState(() => _body = response.body);
    } catch (e) { if (mounted) setState(() => _body = 'Request failed: $e'); }
    finally { if (mounted) setState(() => _loading = false); }
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Raw API Response')),
    body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
      ElevatedButton(onPressed: _loading ? null : _fetch, child: const Text('Fetch')),
      if (_loading) const LinearProgressIndicator(),
      Expanded(child: SingleChildScrollView(child: SelectableText(_body))),
    ])),
  );
}
