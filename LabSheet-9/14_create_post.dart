// Question 14: Submit title/body to a REST API with http.post(). Dependency: http.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: CreatePostPage()));

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});
  @override State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _body = TextEditingController();
  bool _sending = false;
  String? _message;
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _sending = true; _message = null; });
    try {
      final r = await http.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'title': _title.text.trim(), 'body': _body.text.trim(), 'userId': 1}),
      );
      if (r.statusCode != 201) throw Exception('HTTP ${r.statusCode}');
      final result = jsonDecode(r.body) as Map<String, dynamic>;
      if (mounted) setState(() => _message = 'Created successfully (id ${result['id']}).');
    } catch (e) { if (mounted) setState(() => _message = 'Submission failed: $e'); }
    finally { if (mounted) setState(() => _sending = false); }
  }
  @override void dispose() { _title.dispose(); _body.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Create Post')),
    body: Padding(padding: const EdgeInsets.all(16), child: Form(key: _formKey, child: ListView(children: [
      TextFormField(controller: _title, decoration: const InputDecoration(labelText: 'Title'), validator: (v) => v == null || v.trim().isEmpty ? 'Enter a title' : null),
      TextFormField(controller: _body, maxLines: 5, decoration: const InputDecoration(labelText: 'Body'), validator: (v) => v == null || v.trim().isEmpty ? 'Enter a body' : null),
      const SizedBox(height: 16), ElevatedButton(onPressed: _sending ? null : _submit, child: Text(_sending ? 'Sending...' : 'Submit')),
      if (_message != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(_message!)),
    ]))),
  );
}
