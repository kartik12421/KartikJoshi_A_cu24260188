// Question 2: Register with email and password using Firebase Authentication.
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: RegisterPage()));
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final email = TextEditingController(), password = TextEditingController();
  bool busy = false;
  @override
  void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  Future<void> register() async {
    setState(() => busy = true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(), password: password.text,
      );
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully')),
      );
    } on FirebaseAuthException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration failed')),
      );
    } finally { if (mounted) setState(() => busy = false); }
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Register')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(
      children: [TextField(controller: email, keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(labelText: 'Email')),
        TextField(controller: password, obscureText: true,
          decoration: const InputDecoration(labelText: 'Password')),
        const SizedBox(height: 16), ElevatedButton(onPressed: busy ? null : register,
          child: Text(busy ? 'Registering…' : 'Create account'))],
    )),
  );
}
