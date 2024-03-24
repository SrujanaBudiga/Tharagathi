import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/class.dart';
import '../models/student.dart';
import '../models/attendance_record.dart';
import '../models/mark.dart';
import '../models/assignment.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // CRUD operations for classes
  Future<void> addClass(Class newClass) async {
    await _db.collection('classes').add(newClass.toJson());
  }

  Stream<List<Class>> getClasses() {
    return _db.collection('classes').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Class.fromJson(doc.data())).toList());
  }

  Future<Class?> getClass(String classId) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _db.collection('classes').doc(classId).get();
    if (doc.exists) {
      return Class.fromJson(doc.data()!);
    } else {
      return null;
    }
  }

  Future<void> updateClass(Class updatedClass) async {
    await _db
        .collection('classes')
        .doc(updatedClass.id)
        .set(updatedClass.toJson());
  }

  Future<void> deleteClass(String classId) async {
    await _db.collection('classes').doc(classId).delete();
  }

  // CRUD operations for students
  Stream<List<Student>> getStudents(String className) {
    return _db
        .collection('classes')
        .doc(className)
        .collection('students')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Student.fromJson(doc.data())).toList());
  }

  Future<void> addStudent(String className, Student student) async {
    await _db
        .collection('classes')
        .doc(className)
        .collection('students')
        .add(student.toJson());
  }

  Future<void> updateStudent(String className, Student student) async {
    await _db
        .collection('classes')
        .doc(className)
        .collection('students')
        .doc(student.id)
        .set(student.toJson());
  }

  Future<void> deleteStudent(String className, String studentId) async {
    await _db
        .collection('classes')
        .doc(className)
        .collection('students')
        .doc(studentId)
        .delete();
  }

// CRUD operations for attendance records
  Stream<List<AttendanceRecord>> getAttendanceRecords(
          String className, String subject) =>
      _db
          .collection('classes')
          .doc(className)
          .collection('subjects')
          .doc(subject)
          .collection('attendance')
          .orderBy('date')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AttendanceRecord.fromJson(doc.data()))
              .toList());

  Future<void> addAttendanceRecord(
      String className, String subject, AttendanceRecord record) async {
    await _db
        .collection('classes')
        .doc(className)
        .collection('subjects')
        .doc(subject)
        .collection('attendance')
        .add(record.toJson());
  }

  Future<void> updateAttendanceRecord(
      String className, String subject, AttendanceRecord record) async {
    await _db
        .collection('classes')
        .doc(className)
        .collection('subjects')
        .doc(subject)
        .collection('attendance')
        .doc(record.id)
        .set(record.toJson());
  }

  Future<void> deleteAttendanceRecord(
      String className, String subject, String recordId) async {
    await _db
        .collection('classes')
        .doc(className)
        .collection('subjects')
        .doc(subject)
        .collection('attendance')
        .doc(recordId)
        .delete();
  }

  // CRUD operations for marks
  Stream<List<Mark>> getMarks(String className, String subject) => _db
      .collection('classes')
      .doc(className)
      .collection('subjects')
      .doc(subject)
      .collection('marks')
      .orderBy('score')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Mark.fromJson(doc.data())).toList());

  Future<void> addMark(String className, String subject, Mark mark) async {
    await _db
        .collection('classes')
        .doc(className)
        .collection('subjects')
        .doc(subject)
        .collection('marks')
        .add(mark.toJson());
  }

  Future<void> updateMarks(List<Mark> updatedMarks) async {
    for (final mark in updatedMarks) {
      await _db
          .collection('classes')
          .doc(mark.className)
          .collection('marks')
          .doc(mark.id)
          .set(mark.toJson());
    }
  }

  Future<void> deleteMark(
      String className, String subject, String markId) async {
    await _db
        .collection('classes')
        .doc(className)
        .collection('subjects')
        .doc(subject)
        .collection('marks')
        .doc(markId)
        .delete();
  }

  // CRUD operations for assignments
  Stream<List<Assignment>> getAssignments(String className, String subject) =>
      _db
          .collection('classes')
          .doc(className)
          .collection('subjects')
          .doc(subject)
          .collection('assignments')
          .orderBy('dueDate')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Assignment.fromJson(doc.data()))
              .toList());

  Future<void> addAssignment(
      String className, String subject, Assignment assignment) async {
    await _db
        .collection('classes')
        .doc(className)
        .collection('subjects')
        .doc(subject)
        .collection('assignments')
        .add(assignment.toJson());
  }

  Future<void> updateAssignment(
      String className, String subject, Assignment assignment) async {
    await _db
        .collection('classes')
        .doc(className)
        .collection('subjects')
        .doc(subject)
        .collection('assignments')
        .doc(assignment.id)
        .set(assignment.toJson());
  }

  Future<void> deleteAssignment(
      String className, String subject, String assignmentId) async {
    await _db
        .collection('classes')
        .doc(className)
        .collection('subjects')
        .doc(subject)
        .collection('assignments')
        .doc(assignmentId)
        .delete();
  }

  Stream<List<Class>> getClassStream() {
    return FirebaseFirestore.instance.collection('classes').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Class.fromJson(doc.data())).toList());
  }
}
