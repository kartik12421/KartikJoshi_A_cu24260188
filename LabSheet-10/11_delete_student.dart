// Question 11: Delete a student record from Firestore.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: DeleteStudentPage()));
}
class DeleteStudentPage extends StatelessWidget {
  const DeleteStudentPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Delete student')),
    body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('students').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        if (docs.isEmpty) return const Center(child: Text('No students to delete'));
        return ListView(children: docs.map((doc) {
          final data = doc.data();
          return ListTile(title: Text(data['name']?.toString() ?? 'Unnamed'),
            subtitle: Text('Roll: ${data['rollNumber'] ?? '-'} • Course: ${data['course'] ?? '-'}'),
            trailing: IconButton(icon: const Icon(Icons.delete), tooltip: 'Delete',
              onPressed: () async {
                final confirmed = await showDialog<bool>(context: context, builder: (d) => AlertDialog(
                  title: const Text('Delete student?'), content: Text('Delete ${data['name'] ?? 'this student'}?'),
                  actions: [TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(d, true), child: const Text('Delete'))],
                ));
                if (confirmed == true) await doc.reference.delete();
              }));
        }).toList());
      }));
}
