import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/student.dart';
import '../models/attendance_record.dart';

class TakeAttendanceScreen extends StatefulWidget {
  final String className;
  final String subject;

  const TakeAttendanceScreen({super.key, required this.className, required this.subject});

  @override
  _TakeAttendanceScreenState createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  final _firestoreService = FirestoreService();
  final _students = <Student>[];
  final _attendanceRecords = <AttendanceRecord>[];

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

  Future<void> _takeAttendance(Student student) async {
    final attendanceRecord = AttendanceRecord(
      id: '',
      studentId: student.id,
      className: widget.className,
      subject: widget.subject,
      date: DateTime.now(),
      isPresent: true,
    );
    await _firestoreService.addAttendanceRecord(
      widget.className,
      student.id, // Pass the studentId as the second argument
      attendanceRecord,
    );
    setState(() {
      _attendanceRecords.add(attendanceRecord);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Take Attendance for ${widget.className} - ${widget.subject}')),
      body: _students.isNotEmpty
          ? ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text(student.rollNumber),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _takeAttendance(student);
                    },
                    child: const Text('Mark Present'),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
