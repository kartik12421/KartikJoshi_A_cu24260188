// Question 14: A signed-in user can add, view, and delete their Firestore notes.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: NotesAuthGate()));
}
class NotesAuthGate extends StatelessWidget {
  const NotesAuthGate({super.key});
  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) return const Scaffold(body: Center(child: CircularProgressIndicator()));
      return snapshot.data == null ? const NotesLoginPage() : const NotesPage();
    });
}
class NotesLoginPage extends StatefulWidget {
  const NotesLoginPage({super.key});
  @override
  State<NotesLoginPage> createState() => _NotesLoginPageState();
}
class _NotesLoginPageState extends State<NotesLoginPage> {
  final email = TextEditingController(), password = TextEditingController();
  String error = '';
  Future<void> signIn() async {
    try { await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.trim(), password: password.text); }
    on FirebaseAuthException catch (e) { if (mounted) setState(() => error = e.message ?? 'Sign in failed'); }
  }
  @override
  void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Notes login')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
      TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
      ElevatedButton(onPressed: signIn, child: const Text('Sign in')), Text(error),
    ])));
}
class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}
class _NotesPageState extends State<NotesPage> {
  final note = TextEditingController();
  CollectionReference<Map<String, dynamic>> get notes => FirebaseFirestore.instance
    .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('notes');
  @override
  void dispose() { note.dispose(); super.dispose(); }
  Future<void> addNote() async {
    final text = note.text.trim();
    if (text.isEmpty) return;
    await notes.add({'text': text, 'createdAt': FieldValue.serverTimestamp()});
    note.clear();
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('My notes'), actions: [
    IconButton(onPressed: () => FirebaseAuth.instance.signOut(), icon: const Icon(Icons.logout), tooltip: 'Logout')]),
    body: Column(children: [Padding(padding: const EdgeInsets.all(12), child: Row(children: [
      Expanded(child: TextField(controller: note, decoration: const InputDecoration(labelText: 'Write a note'))),
      IconButton(onPressed: addNote, icon: const Icon(Icons.add), tooltip: 'Add note'),
    ])), Expanded(child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: notes.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        if (snapshot.data!.docs.isEmpty) return const Center(child: Text('No notes yet'));
        return ListView(children: snapshot.data!.docs.map((doc) => ListTile(
          title: Text(doc.data()['text']?.toString() ?? ''),
          trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => doc.reference.delete()))).toList());
      }))]));
}
