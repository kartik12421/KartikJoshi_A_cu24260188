// Question 1: Initialize Firebase and show a connection message.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart'; // Generate with: flutterfire configure

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: Scaffold(
    body: Center(child: Text('Firebase Connected', style: TextStyle(fontSize: 24))),
  )));
}
