// Question 15: Authenticated student management with Firestore CRUD.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: ManagementAuthGate()));
}
class ManagementAuthGate extends StatelessWidget {
  const ManagementAuthGate({super.key});
  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) return const Scaffold(body: Center(child: CircularProgressIndicator()));
      return snapshot.data == null ? const ManagementLoginPage() : const StudentManagementPage();
    });
}
class ManagementLoginPage extends StatefulWidget {
  const ManagementLoginPage({super.key});
  @override
  State<ManagementLoginPage> createState() => _ManagementLoginPageState();
}
class _ManagementLoginPageState extends State<ManagementLoginPage> {
  final email = TextEditingController(), password = TextEditingController();
  String error = '';
  Future<void> authenticate(bool register) async {
    try {
      if (register) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text);
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.trim(), password: password.text);
      }
    } on FirebaseAuthException catch (e) { if (mounted) setState(() => error = e.message ?? 'Authentication failed'); }
  }
  @override
  void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Student manager login')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email')),
      TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
      ElevatedButton(onPressed: () => authenticate(false), child: const Text('Login')),
      TextButton(onPressed: () => authenticate(true), child: const Text('Register')),
      Text(error),
    ])));
}
class StudentManagementPage extends StatelessWidget {
  const StudentManagementPage({super.key});
  CollectionReference<Map<String, dynamic>> get students => FirebaseFirestore.instance.collection('students');
  Future<void> editStudent(BuildContext context, {String? id, Map<String, dynamic>? data}) async {
    final name = TextEditingController(text: data?['name']?.toString() ?? '');
    final roll = TextEditingController(text: data?['rollNumber']?.toString() ?? '');
    final course = TextEditingController(text: data?['course']?.toString() ?? '');
    final save = await showDialog<bool>(context: context, builder: (d) => AlertDialog(
      title: Text(id == null ? 'Add student' : 'Update student'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
        TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll number')),
        TextField(controller: course, decoration: const InputDecoration(labelText: 'Course')),
      ]),
      actions: [TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancel')),
        ElevatedButton(onPressed: () => Navigator.pop(d, true), child: const Text('Save'))],
    ));
    if (save == true && name.text.trim().isNotEmpty && roll.text.trim().isNotEmpty && course.text.trim().isNotEmpty) {
      final Map<String, Object?> values = {'name': name.text.trim(), 'rollNumber': roll.text.trim(), 'course': course.text.trim()};
      if (id == null) { values['createdAt'] = FieldValue.serverTimestamp(); await students.add(values); }
      else { values['updatedAt'] = FieldValue.serverTimestamp(); await students.doc(id).update(values); }
    }
    name.dispose(); roll.dispose(); course.dispose();
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Student management'), actions: [
    IconButton(onPressed: () => FirebaseAuth.instance.signOut(), icon: const Icon(Icons.logout), tooltip: 'Logout')]),
    floatingActionButton: FloatingActionButton(onPressed: () => editStudent(context), child: const Icon(Icons.add), tooltip: 'Add student'),
    body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: students.orderBy('name').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        if (snapshot.data!.docs.isEmpty) return const Center(child: Text('No students yet. Add one.'));
        return ListView(children: snapshot.data!.docs.map((doc) {
          final data = doc.data();
          return ListTile(title: Text(data['name']?.toString() ?? 'Unnamed'),
            subtitle: Text('Roll: ${data['rollNumber'] ?? '-'} • Course: ${data['course'] ?? '-'}'),
            onTap: () => editStudent(context, id: doc.id, data: data),
            trailing: IconButton(icon: const Icon(Icons.delete), tooltip: 'Delete',
              onPressed: () => doc.reference.delete()));
        }).toList());
      }));
}
