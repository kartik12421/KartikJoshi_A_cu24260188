// Dependencies: path_provider
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const MaterialApp(home: ReadFilePage()));

class ReadFilePage extends StatefulWidget {
  const ReadFilePage({super.key});
  @override
  State<ReadFilePage> createState() => _ReadFilePageState();
}

class _ReadFilePageState extends State<ReadFilePage> {
  String contents = 'Press Read to load message.txt';
  Future<void> _read() async {
    final dir = await getApplicationDocumentsDirectory(); final file = File('${dir.path}/message.txt');
    final text = await file.exists() ? await file.readAsString() : 'File not found. Save it with question 12 first.';
    if (mounted) setState(() => contents = text);
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Read from File')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      ElevatedButton(onPressed: _read, child: const Text('Read file')), Text(contents),
    ])));
}
