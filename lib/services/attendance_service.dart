import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/attendance_record.dart';

class AttendanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAttendanceRecord({
    required String className,
    required String studentId,
    required AttendanceRecord attendance,
  }) async {
    await _firestore
        .collection('classes')
        .doc(className)
        .collection('students')
        .doc(studentId)
        .collection('attendance')
        .add(attendance.toJson());
  }
}
