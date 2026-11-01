// Question 8: Add a student record to Cloud Firestore.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: AddStudentPage()));
}
class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});
  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}
class _AddStudentPageState extends State<AddStudentPage> {
  final name = TextEditingController(), roll = TextEditingController(), course = TextEditingController();
  @override
  void dispose() { name.dispose(); roll.dispose(); course.dispose(); super.dispose(); }
  Future<void> save() async {
    if (name.text.trim().isEmpty || roll.text.trim().isEmpty || course.text.trim().isEmpty) return;
    await FirebaseFirestore.instance.collection('students').add({
      'name': name.text.trim(), 'rollNumber': roll.text.trim(), 'course': course.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student saved')));
    name.clear(); roll.clear(); course.clear();
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Add student')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
      TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll number')),
      TextField(controller: course, decoration: const InputDecoration(labelText: 'Course')),
      ElevatedButton(onPressed: save, child: const Text('Save student')),
    ])));
}
