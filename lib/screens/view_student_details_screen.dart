import 'package:flutter/material.dart';
import 'package:com.example.tharagathi/models/class.dart';
import '../services/firestore_service.dart';
import '../models/student.dart';

class ViewStudentDetailsScreen extends StatefulWidget {
  final String className;

  const ViewStudentDetailsScreen({super.key, required this.className, required Class classDoc});

  @override
  _ViewStudentDetailsScreenState createState() => _ViewStudentDetailsScreenState();
}

class _ViewStudentDetailsScreenState extends State<ViewStudentDetailsScreen> {
  final _firestoreService = FirestoreService();
  final _students = <Student>[];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final classDoc = await _firestoreService.getClass(widget.className);
    if (classDoc != null) {
      setState(() {
        _students.clear();
        _students.addAll(classDoc.students);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Details for ${widget.className}')),
      body: _students.isNotEmpty
          ? ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text(student.rollNumber),
                  trailing: Text(student.email),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}