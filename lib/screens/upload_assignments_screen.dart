import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/assignment.dart';

class UploadAssignmentsScreen extends StatefulWidget {
  final String className;
  final String subject;

  const UploadAssignmentsScreen({super.key, required this.className, required this.subject});

  @override
  _UploadAssignmentsScreenState createState() =>
      _UploadAssignmentsScreenState();
}

class _UploadAssignmentsScreenState extends State<UploadAssignmentsScreen> {
  final _firestoreService = FirestoreService();
  final _assignments = <Assignment>[];

  @override
  void initState() {
    super.initState();
    _loadAssignments();
  }

  Future<void> _loadAssignments() async {
    final classDoc = await _firestoreService.getClass(widget.className);
    if (classDoc != null) {
      setState(() {
        _assignments.clear();
        _assignments.addAll(classDoc.assignments as Iterable<Assignment>);
      });
    }
  }

  Future<void> _uploadAssignments() async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Upload Assignments for ${widget.className} - ${widget.subject}')),
      body: _assignments.isNotEmpty
          ? ListView.builder(
              itemCount: _assignments.length,
              itemBuilder: (context, index) {
                final assignment = _assignments[index];
                return ListTile(
                  title: Text(assignment.title),
                  subtitle: Text(assignment.dueDate.toString()),
                  trailing: Text(assignment.url),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadAssignments,
        child: const Icon(Icons.check),
      ),
    );
  }
}
