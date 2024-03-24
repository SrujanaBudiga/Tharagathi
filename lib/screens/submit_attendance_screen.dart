import 'package:flutter/material.dart';
import '../services/attendance_service.dart';
import '../models/attendance_record.dart';

class SubmitAttendanceScreen extends StatefulWidget {
  final String className;
  final String studentId;

  const SubmitAttendanceScreen({super.key, required this.className, required this.studentId});

  @override
  _SubmitAttendanceScreenState createState() => _SubmitAttendanceScreenState();
}

class _SubmitAttendanceScreenState extends State<SubmitAttendanceScreen> {
  final AttendanceService _attendanceService = AttendanceService();
  bool _isPresent = false;

  Future<void> _submitAttendance() async {
    final attendanceRecord = AttendanceRecord(
      id: '',
      studentId: widget.studentId,
      className: widget.className,
      subject: '',
      date: DateTime.now(),
      isPresent: _isPresent,
    );
    await _attendanceService.addAttendanceRecord(
      className: widget.className,
      studentId: widget.studentId,
      attendance: attendanceRecord,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Submit Attendance for ${widget.className} - ${widget.studentId}')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Are you present today?'),
          SwitchListTile(
            value: _isPresent,
            onChanged: (value) {
              setState(() {
                _isPresent = value;
              });
            },
            title: const Text('Present'),
          ),
          ElevatedButton(
            onPressed: _submitAttendance,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}