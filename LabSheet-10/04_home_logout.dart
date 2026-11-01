// Question 4: Show the signed-in email and provide logout.
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: UserHomePage()));
}
class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(appBar: AppBar(title: const Text('Home')),
      body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Logged in as: ${user?.email ?? 'No user signed in'}'),
        ElevatedButton(onPressed: () => FirebaseAuth.instance.signOut(),
          child: const Text('Logout')),
      ])));
  }
}
