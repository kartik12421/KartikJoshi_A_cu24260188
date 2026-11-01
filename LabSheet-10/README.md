# Lab Sheet 10 — Flutter Firebase Authentication and Cloud Firestore

Each numbered Dart file answers the matching question in `10.pdf`. Every file is an independent Flutter app entry point; use one at a time as `lib/main.dart` in a Flutter project.

## Setup

1. Create a Flutter project and connect it to your Firebase project with the FlutterFire CLI: `flutterfire configure`. This generates `lib/firebase_options.dart`, imported by each example.
2. Add the required packages: `flutter pub add firebase_core firebase_auth cloud_firestore` (Firestore examples use `cloud_firestore`; Authentication examples use `firebase_auth`).
3. In Firebase Console, enable Email/Password under Authentication for questions 2–7, 14, and 15. Create a Cloud Firestore database for questions 8–15.
4. Copy a selected numbered file to `lib/main.dart` and run `flutter run`.

Files are numbered `01` through `15` to match the worksheet. Student examples share the `students` collection with fields `name`, `rollNumber`, and `course`. The Notes app stores notes under `users/{uid}/notes`, scoped to the signed-in account. Set Firestore security rules appropriate to your project before using real data.
