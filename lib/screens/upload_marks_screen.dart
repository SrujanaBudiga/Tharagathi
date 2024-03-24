import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';
import '../models/mark.dart';

class UploadMarksScreen extends StatefulWidget {
  final String className;
  final String subject;
  final List<String> students;

  const UploadMarksScreen(
      {super.key, required this.className, required this.subject, required this.students});

  @override
  _UploadMarksScreenState createState() => _UploadMarksScreenState();
}

class _UploadMarksScreenState extends State<UploadMarksScreen> {
  final _firestoreService = FirestoreService();
  final _formKey = GlobalKey<FormState>();
  final List<Mark> _marks = [];
  final String _selectedStudentId = '';
  String _selectedClassName = '';
  String _selectedSubject = '';
  final _markController = TextEditingController();

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
        _selectedClassName = classDoc.name;
        _selectedSubject = widget.subject;
      });
    }
  }

  Future<void> _uploadMarks() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final updatedMarks = _marks.map((mark) {
        if (mark.studentId == _selectedStudentId &&
            mark.className == _selectedClassName &&
            mark.subject == _selectedSubject) {
          return Mark(
            id: mark.id,
            studentId: mark.studentId,
            className: mark.className,
            subject: mark.subject,
            score: double.parse(_markController.text),
          );
        } else {
          return mark;
        }
      }).toList();

      final firestoreService =
          Provider.of<FirestoreService>(context, listen: false);
      await firestoreService.updateMarks(updatedMarks);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Marks for ${widget.className} - ${widget.subject}'),
      ),
      body: _marks.isNotEmpty
          ? ListView.builder(
        itemCount: _marks.length,
        itemBuilder: (context, index) {
          final mark = _marks[index];
          final student = _students.firstWhere((student) => student.id == mark.studentId);
          return ListTile(
            title: Text(student.name),
            subtitle: Text(student.rollNumber),
            trailing: TextFormField(
              initialValue: mark.score.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final updatedMark = mark.copyWith(score: double.tryParse(value) ?? 0);
                setState(() {
                  _marks[index] = updatedMark;
                });
              },
            ),
          );
        },
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadMarks,
        child: const Icon(Icons.check),
      ),
    );
  }
}

class _students {
  static firstWhere(bool Function(dynamic student) param0) {}
}
