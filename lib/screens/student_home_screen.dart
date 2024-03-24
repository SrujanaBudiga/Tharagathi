import 'package:flutter/material.dart';
import 'check_attendance_screen.dart';
import 'check_marks_screen.dart';
import 'submit_attendance_screen.dart';

class StudentHomeScreen extends StatelessWidget {
  final String className;
  final String studentId;
  final String subject;
  const StudentHomeScreen({super.key, required this.className, required this.studentId, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Home')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckAttendanceScreen(
                        className: className,
                        studentId: studentId,
                      )));
            },
            child: const Text('Check Attendance'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CheckMarksScreen(
                    className: className,
                    studentId: studentId,
                    subject: subject,
                  )));
            },
            child: const Text('Check Marks'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SubmitAttendanceScreen(
                        className: className,
                        studentId: studentId,
                      )));
            },
            child: const Text('Submit Attendance'),
          ),
        ],
      ),
    );
  }
}