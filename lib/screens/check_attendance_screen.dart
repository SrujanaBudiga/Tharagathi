import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/attendance_record.dart';

class CheckAttendanceScreen extends StatefulWidget {
  final String className;
  final String studentId;

  const CheckAttendanceScreen({super.key, required this.className, required this.studentId});

  @override
  _CheckAttendanceScreenState createState() => _CheckAttendanceScreenState();
}

class _CheckAttendanceScreenState extends State<CheckAttendanceScreen> {
  final _firestoreService = FirestoreService();
  final _attendanceRecords = <AttendanceRecord>[];

  @override
  void initState() {
    super.initState();
    _loadAttendanceRecords();
  }

  Future<void> _loadAttendanceRecords() async {
    final classDoc = await _firestoreService.getClass(widget.className);
    if (classDoc != null) {
      setState(() {
        _attendanceRecords.clear();
        _attendanceRecords.addAll(classDoc.attendanceRecords);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text('Attendance for ${widget.className} - ${widget.studentId}')),
      body: _attendanceRecords.isNotEmpty
          ? ListView.builder(
              itemCount: _attendanceRecords.length,
              itemBuilder: (context, index) {
                final attendanceRecord = _attendanceRecords[index];
                return ListTile(
                  title: Text(attendanceRecord.subject),
                  subtitle: Text(attendanceRecord.date.toString()),
                  trailing:
                      Text(attendanceRecord.isPresent ? 'Present' : 'Absent'),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
