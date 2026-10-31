import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: FeedbackApp()));

class FeedbackApp extends StatefulWidget {
  const FeedbackApp({super.key});
  State<FeedbackApp> createState() => _FeedbackAppState();
}

class _FeedbackAppState extends State<FeedbackApp> {
  int rating = 3;
  final feedback = TextEditingController();

  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Feedback')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      const TextField(decoration: InputDecoration(labelText: 'Name')),
      DropdownButton<int>(
        value: rating,
        items: [1,2,3,4,5].map((x) => DropdownMenuItem(value: x, child: Text('$x Star'))).toList(),
        onChanged: (v) => setState(() => rating = v!),
      ),
      TextField(controller: feedback, decoration: const InputDecoration(labelText: 'Feedback')),
      ElevatedButton(onPressed: () {}, child: const Text('Submit')),
    ])),
  );
}