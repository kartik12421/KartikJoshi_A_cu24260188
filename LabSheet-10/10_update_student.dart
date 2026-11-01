// Question 10: Update a selected Firestore student record.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: UpdateStudentPage()));
}
class UpdateStudentPage extends StatelessWidget {
  const UpdateStudentPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Update student')),
    body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('students').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        if (docs.isEmpty) return const Center(child: Text('No students to update'));
        return ListView(children: docs.map((doc) {
          final data = doc.data();
          return ListTile(title: Text(data['name']?.toString() ?? 'Unnamed'),
            subtitle: Text('Roll: ${data['rollNumber'] ?? '-'} • Course: ${data['course'] ?? '-'}'),
            trailing: IconButton(icon: const Icon(Icons.edit), tooltip: 'Edit',
              onPressed: () => _editStudent(context, doc.id, data)));
        }).toList());
      }));
}
Future<void> _editStudent(BuildContext context, String id, Map<String, dynamic> data) async {
  final name = TextEditingController(text: data['name']?.toString() ?? '');
  final roll = TextEditingController(text: data['rollNumber']?.toString() ?? '');
  final course = TextEditingController(text: data['course']?.toString() ?? '');
  final save = await showDialog<bool>(context: context, builder: (dialogContext) => AlertDialog(
    title: const Text('Edit student'), content: Column(mainAxisSize: MainAxisSize.min, children: [
      TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
      TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll number')),
      TextField(controller: course, decoration: const InputDecoration(labelText: 'Course')),
    ]), actions: [TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
      ElevatedButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Save'))],
  ));
  if (save == true) {
    await FirebaseFirestore.instance.collection('students').doc(id).update({
      'name': name.text.trim(), 'rollNumber': roll.text.trim(), 'course': course.text.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
  name.dispose(); roll.dispose(); course.dispose();
}
