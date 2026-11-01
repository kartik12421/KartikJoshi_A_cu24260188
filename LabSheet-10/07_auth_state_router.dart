// Question 7: Show Login or Home automatically from authStateChanges().
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: AuthRouter()));
}
class AuthRouter extends StatelessWidget {
  const AuthRouter({super.key});
  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      return snapshot.data == null ? const LoginForm() : const AuthHome();
    });
}
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}
class _LoginFormState extends State<LoginForm> {
  final email = TextEditingController(), password = TextEditingController();
  String error = '';
  Future<void> login() async {
    try { await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text.trim(), password: password.text); }
    on FirebaseAuthException catch (e) { if (mounted) setState(() => error = e.message ?? 'Login failed'); }
  }
  @override
  void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Login')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
      TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
      ElevatedButton(onPressed: login, child: const Text('Sign in')), Text(error),
    ])));
}
class AuthHome extends StatelessWidget {
  const AuthHome({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Home')),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text('Welcome ${FirebaseAuth.instance.currentUser?.email ?? ''}'),
      ElevatedButton(onPressed: () => FirebaseAuth.instance.signOut(), child: const Text('Logout')),
    ])));
}
