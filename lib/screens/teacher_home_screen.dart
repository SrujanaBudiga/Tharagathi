import 'package:flutter/material.dart';
import 'create_class_screen.dart';
import 'take_attendance_screen.dart';
import 'upload_marks_screen.dart';
import 'upload_assignments_screen.dart';
import 'view_student_details_screen.dart';
import '../services/firestore_service.dart';
import '../models/class.dart';

class TeacherHomeScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teacher Home')),
      body: StreamBuilder<List<Class>>(
        stream: _firestoreService.getClassStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final classes = snapshot.data!;
          return ListView.builder(
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final classDoc = classes[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(classDoc.name),
                    subtitle: Text(classDoc.students.first.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.create),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateClassScreen(classDoc: classDoc),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TakeAttendanceScreen(
                            className: classDoc.name,
                            subject: classDoc.students.first.subjects.join(', '),
                          ),
                        ),
                      );
                    },
                    child: const Text('Take Attendance'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadMarksScreen(
                            className: classDoc.name,
                            subject: classDoc.students.first.subjects.join(', '),
                            students: classDoc.students.map((student) => student.id).toList(),
                          ),
                        ),
                      );
                    },
                    child: const Text('Upload Marks'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadAssignmentsScreen(
                            className: classDoc.name,
                            subject: classDoc.students.first.subjects.join(', '),
                          ),
                        ),
                      );
                    },
                    child: const Text('Upload Assignments'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewStudentDetailsScreen(classDoc: classDoc, className: '',),
                        ),
                      );
                    },
                    child: const Text('View Student Details'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}