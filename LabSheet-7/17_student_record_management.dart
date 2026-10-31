// Dependencies: sqflite, path
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class Student {
  final int? id;
  final String name, rollNumber, course;
  const Student({this.id, required this.name, required this.rollNumber, required this.course});
  Map<String, Object?> toMap() => {'id': id, 'name': name, 'rollNumber': rollNumber, 'course': course};
  factory Student.fromMap(Map<String, Object?> map) => Student(id: map['id'] as int?, name: map['name'] as String, rollNumber: map['rollNumber'] as String, course: map['course'] as String);
}

class DatabaseHelper {
  DatabaseHelper._();
  static final instance = DatabaseHelper._();
  static Database? _database;
  Future<Database> get database async => _database ??= await _openDatabase();
  Future<Database> _openDatabase() async => openDatabase(
        p.join(await getDatabasesPath(), 'student_records.db'),
        version: 1,
        onCreate: (db, version) => db.execute(
          'CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, rollNumber TEXT NOT NULL UNIQUE, course TEXT NOT NULL)',
        ),
      );
  Future<int> insert(Student student) async => (await database).insert('students', student.toMap());
  Future<List<Student>> readAll() async {
    final rows = await (await database).query('students', orderBy: 'name COLLATE NOCASE');
    return rows.map(Student.fromMap).toList();
  }
  Future<int> update(Student student) async => (await database).update(
        'students', student.toMap(), where: 'id = ?', whereArgs: [student.id],
      );
  Future<int> delete(int id) async => (await database).delete('students', where: 'id = ?', whereArgs: [id]);
}

void main() => runApp(const StudentManagementApp());

class StudentManagementApp extends StatelessWidget {
  const StudentManagementApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Student Records',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), useMaterial3: true),
        home: const StudentManagementPage(),
      );
}

class StudentManagementPage extends StatefulWidget {
  const StudentManagementPage({super.key});
  @override
  State<StudentManagementPage> createState() => _StudentManagementPageState();
}

class _StudentManagementPageState extends State<StudentManagementPage> {
  List<Student> students = [];
  bool loading = true;

  @override
  void initState() { super.initState(); _loadStudents(); }

  Future<void> _loadStudents() async {
    final result = await DatabaseHelper.instance.readAll();
    if (mounted) setState(() { students = result; loading = false; });
  }

  Future<void> _showStudentForm({Student? existing}) async {
    final name = TextEditingController(text: existing?.name ?? '');
    final roll = TextEditingController(text: existing?.rollNumber ?? '');
    final course = TextEditingController(text: existing?.course ?? '');
    final formKey = GlobalKey<FormState>();
    final values = await showDialog<List<String>>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(existing == null ? 'Add student' : 'Edit student'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(controller: name, decoration: const InputDecoration(labelText: 'Name'), textCapitalization: TextCapitalization.words, validator: _required),
            TextFormField(controller: roll, decoration: const InputDecoration(labelText: 'Roll number'), validator: _required),
            TextFormField(controller: course, decoration: const InputDecoration(labelText: 'Course'), textCapitalization: TextCapitalization.words, validator: _required),
          ])),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          FilledButton(onPressed: () { if (formKey.currentState!.validate()) Navigator.pop(dialogContext, [name.text.trim(), roll.text.trim(), course.text.trim()]); }, child: const Text('Save')),
        ],
      ),
    );
    name.dispose(); roll.dispose(); course.dispose();
    if (values == null || !mounted) return;
    final student = Student(id: existing?.id, name: values[0], rollNumber: values[1], course: values[2]);
    try {
      if (existing == null) { await DatabaseHelper.instance.insert(student); }
      else { await DatabaseHelper.instance.update(student); }
      await _loadStudents();
    } on DatabaseException catch (error) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not save student. Roll numbers must be unique. $error')));
    }
  }

  String? _required(String? value) => value == null || value.trim().isEmpty ? 'This field is required' : null;

  Future<void> _deleteStudent(Student student) async {
    await DatabaseHelper.instance.delete(student.id!);
    await _loadStudents();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Student Records')),
        floatingActionButton: FloatingActionButton.extended(onPressed: () => _showStudentForm(), icon: const Icon(Icons.person_add), label: const Text('Add student')),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : students.isEmpty
                ? const Center(child: Text('No student records yet. Tap “Add student” to begin.'))
                : ListView.separated(
                    padding: const EdgeInsets.only(bottom: 88, top: 8),
                    itemCount: students.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return ListTile(
                        leading: CircleAvatar(child: Text(student.name.isEmpty ? '?' : student.name[0].toUpperCase())),
                        title: Text(student.name),
                        subtitle: Text('Roll: ${student.rollNumber}\nCourse: ${student.course}'),
                        isThreeLine: true,
                        onTap: () => _showStudentForm(existing: student),
                        trailing: IconButton(tooltip: 'Delete student', icon: const Icon(Icons.delete_outline), onPressed: () => _deleteStudent(student)),
                      );
                    },
                  ),
      );
}
