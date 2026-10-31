import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Students()));

class Student {
  String name, roll, course;
  Student(this.name, this.roll, this.course);
}

class Students extends StatefulWidget {
  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  List<Student> students = [];
  TextEditingController name = TextEditingController();
  TextEditingController roll = TextEditingController();
  TextEditingController course = TextEditingController();
  String search = "";

  void addStudent() {
    if (name.text.isEmpty || roll.text.isEmpty || course.text.isEmpty) return;

    setState(() {
      students.add(Student(name.text, roll.text, course.text));
      name.clear();
      roll.clear();
      course.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var result = students
        .where((s) => s.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text("Student Records")),
      body: Column(
        children: [
          TextField(
            controller: name,
            decoration: InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: roll,
            decoration: InputDecoration(labelText: "Roll No"),
          ),
          TextField(
            controller: course,
            decoration: InputDecoration(labelText: "Course"),
          ),
          ElevatedButton(
            onPressed: addStudent,
            child: Text("Add Student"),
          ),
          TextField(
            decoration: InputDecoration(labelText: "Search Name"),
            onChanged: (v) => setState(() => search = v),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, i) => ListTile(
                title: Text(result[i].name),
                subtitle: Text(
                  "Roll: ${result[i].roll} | ${result[i].course}",
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() => students.remove(result[i]));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}