// Question 5: Display Firebase Authentication errors in a SnackBar.
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: AuthErrorPage()));
}
class AuthErrorPage extends StatefulWidget {
  const AuthErrorPage({super.key});
  @override
  State<AuthErrorPage> createState() => _AuthErrorPageState();
}
class _AuthErrorPageState extends State<AuthErrorPage> {
  final email = TextEditingController(), password = TextEditingController();
  @override
  void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  Future<void> runAuth(Future<UserCredential> Function() action) async {
    try {
      await action();
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication successful')));
    } on FirebaseAuthException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Authentication failed (${e.code})')));
    }
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Auth errors')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
      TextField(controller: password, obscureText: true,
        decoration: const InputDecoration(labelText: 'Password')),
      ElevatedButton(onPressed: () => runAuth(() => FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.text.trim(), password: password.text)),
        child: const Text('Register')),
      ElevatedButton(onPressed: () => runAuth(() => FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text.trim(), password: password.text)),
        child: const Text('Login')),
    ])));
}
