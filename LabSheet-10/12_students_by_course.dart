// Question 12: Query students by a selected course with where().
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: CourseStudentsPage()));
}
class CourseStudentsPage extends StatefulWidget {
  const CourseStudentsPage({super.key});
  @override
  State<CourseStudentsPage> createState() => _CourseStudentsPageState();
}
class _CourseStudentsPageState extends State<CourseStudentsPage> {
  final course = TextEditingController();
  String selectedCourse = '';
  @override
  void dispose() { course.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Students by course')),
    body: Column(children: [Padding(padding: const EdgeInsets.all(12), child: Row(children: [
      Expanded(child: TextField(controller: course, decoration: const InputDecoration(labelText: 'Course'))),
      IconButton(onPressed: () => setState(() => selectedCourse = course.text.trim()), icon: const Icon(Icons.search)),
    ])), Expanded(child: selectedCourse.isEmpty ? const Center(child: Text('Enter a course to search')) :
      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('students')
          .where('course', isEqualTo: selectedCourse).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) return const Center(child: Text('No students in this course'));
          return ListView(children: docs.map((doc) => ListTile(
            title: Text(doc.data()['name']?.toString() ?? 'Unnamed'),
            subtitle: Text('Roll: ${doc.data()['rollNumber'] ?? '-'}'))).toList());
        }))]));
}
