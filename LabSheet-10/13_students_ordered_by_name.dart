// Question 13: Display students in ascending name order using orderBy().
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: OrderedStudentsPage()));
}
class OrderedStudentsPage extends StatelessWidget {
  const OrderedStudentsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Students by name')),
    body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('students').orderBy('name').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        if (docs.isEmpty) return const Center(child: Text('No students found'));
        return ListView(children: docs.map((doc) => ListTile(
          title: Text(doc.data()['name']?.toString() ?? 'Unnamed'),
          subtitle: Text('Roll: ${doc.data()['rollNumber'] ?? '-'} • Course: ${doc.data()['course'] ?? '-'}'))).toList());
      }));
}
