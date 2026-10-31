# Lab Sheet 7 — Flutter SQLite

Each numbered Dart file corresponds to the same question number in `7.pdf` and contains a separate Flutter example. Run one example at a time as the app entry point.

## Dependencies

In a Flutter project, add these packages to `pubspec.yaml` (or run `flutter pub add sqflite path`):

```yaml
dependencies:
  flutter:
    sdk: flutter
  path: ^1.9.0
  sqflite: ^2.4.0
```

The examples use the database name `students.db` and a `students` table with `id`, `name`, `rollNumber`, and `course` columns. Questions 1–16 share that database name so the CRUD examples can work with the same records. Question 17 is a complete app with its own `student_records.db` database.

For an example that refers to the `students` table, launch it once to create the table before using the other operations. Question 1 and 2 demonstrate database and table creation separately.
