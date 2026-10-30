// Dependencies: path_provider
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const MaterialApp(home: WriteFilePage()));

class WriteFilePage extends StatefulWidget {
  const WriteFilePage({super.key});
  @override
  State<WriteFilePage> createState() => _WriteFilePageState();
}

class _WriteFilePageState extends State<WriteFilePage> {
  final controller = TextEditingController(); String status = '';
  Future<void> _write() async {
    final dir = await getApplicationDocumentsDirectory(); final file = File('${dir.path}/message.txt');
    await file.writeAsString(controller.text);
    if (mounted) setState(() => status = 'Saved to ${file.path}');
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Write to File')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: controller, maxLines: 5, decoration: const InputDecoration(labelText: 'Text to save')),
      ElevatedButton(onPressed: _write, child: const Text('Write file')), Text(status),
    ])));
  @override
  void dispose() { controller.dispose(); super.dispose(); }
}
