// Dependency: shared_preferences
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfile {
  final String name, rollNumber, course;
  final int semester;
  const StudentProfile({required this.name, required this.rollNumber, required this.course, required this.semester});
}

void main() => runApp(const MaterialApp(home: StudentProfilePage()));

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});
  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  final name = TextEditingController(), roll = TextEditingController(), course = TextEditingController(), semester = TextEditingController();
  StudentProfile? profile;
  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async {
    final p = await SharedPreferences.getInstance(); final n = p.getString('spName'); if (n == null) return;
    final value = StudentProfile(name: n, rollNumber: p.getString('spRoll') ?? '', course: p.getString('spCourse') ?? '', semester: p.getInt('spSemester') ?? 1);
    if (mounted) setState(() { profile = value; _fill(value); });
  }
  void _fill(StudentProfile p) { name.text = p.name; roll.text = p.rollNumber; course.text = p.course; semester.text = p.semester.toString(); }
  Future<void> _save() async {
    final sem = int.tryParse(semester.text.trim());
    if (name.text.trim().isEmpty || roll.text.trim().isEmpty || course.text.trim().isEmpty || sem == null || sem < 1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Complete all fields and enter a valid semester'))); return;
    }
    final value = StudentProfile(name: name.text.trim(), rollNumber: roll.text.trim(), course: course.text.trim(), semester: sem);
    final p = await SharedPreferences.getInstance();
    await p.setString('spName', value.name); await p.setString('spRoll', value.rollNumber); await p.setString('spCourse', value.course); await p.setInt('spSemester', value.semester);
    if (mounted) setState(() => profile = value);
  }
  Future<void> _clear() async {
    final p = await SharedPreferences.getInstance();
    for (final key in ['spName', 'spRoll', 'spCourse', 'spSemester']) { await p.remove(key); }
    if (mounted) setState(() { profile = null; name.clear(); roll.clear(); course.clear(); semester.clear(); });
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Student Profile')),
    body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
      TextField(controller: roll, decoration: const InputDecoration(labelText: 'Roll number')),
      TextField(controller: course, decoration: const InputDecoration(labelText: 'Course')),
      TextField(controller: semester, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Semester')),
      Row(children: [Expanded(child: ElevatedButton(onPressed: _save, child: const Text('Save / Update'))), const SizedBox(width: 8), Expanded(child: OutlinedButton(onPressed: _clear, child: const Text('Clear profile')))]),
      if (profile != null) Card(child: ListTile(title: Text(profile!.name), subtitle: Text('Roll: ${profile!.rollNumber}\nCourse: ${profile!.course}\nSemester: ${profile!.semester}'))),
    ])));
  @override
  void dispose() { name.dispose(); roll.dispose(); course.dispose(); semester.dispose(); super.dispose(); }
}
