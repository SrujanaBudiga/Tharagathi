import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/mark.dart';

class CheckMarksScreen extends StatefulWidget {
  final String className;
  final String studentId;
  final String subject;

  const CheckMarksScreen(
      {super.key, required this.className,
      required this.studentId,
      required this.subject});

  @override
  _CheckMarksScreenState createState() => _CheckMarksScreenState();
}

class _CheckMarksScreenState extends State<CheckMarksScreen> {
  final _firestoreService = FirestoreService();
  final _marks = <Mark>[];

  @override
  void initState() {
    super.initState();
    _loadMarks();
  }

  Future<void> _loadMarks() async {
    final classDoc = await _firestoreService.getClass(widget.className);
    if (classDoc != null) {
      setState(() {
        _marks.clear();
        _marks.addAll(classDoc.marks);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Marks for ${widget.className} - ${widget.subject} - ${widget.studentId}')),
      body: _marks.isNotEmpty
          ? ListView.builder(
              itemCount: _marks.length,
              itemBuilder: (context, index) {
                final mark = _marks[index];
                return ListTile(
                  title: Text(mark.subject),
                  subtitle: Text(mark.score.toString()),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
