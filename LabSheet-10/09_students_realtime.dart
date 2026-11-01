// Question 9: Display Firestore student records in real time.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: StudentsPage()));
}
class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Students')),
    body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('students').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        if (docs.isEmpty) return const Center(child: Text('No students found'));
        return ListView.builder(itemCount: docs.length, itemBuilder: (context, i) {
          final data = docs[i].data();
          return ListTile(title: Text(data['name']?.toString() ?? 'Unnamed'),
            subtitle: Text('Roll: ${data['rollNumber'] ?? '-'} • Course: ${data['course'] ?? '-'}'));
        });
      }));
}
