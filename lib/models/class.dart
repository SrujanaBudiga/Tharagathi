import 'attendance_record.dart';
import 'mark.dart';
import 'student.dart';

class Class {
  final String id;
  final String name;
  final List<Student> students;
  final List<AttendanceRecord> attendanceRecords;
  final List<Mark> marks;
  final List<String> assignments;

  Class({
    required this.id,
    required this.name,
    required this.students,
    required this.attendanceRecords,
    required this.marks,
    required this.assignments,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      name: json['name'],
      students: (json['students'] as List)
          .map((studentJson) => Student.fromJson(studentJson))
          .toList(),
      attendanceRecords: (json['attendanceRecords'] as List)
          .map((attendanceRecordJson) =>
              AttendanceRecord.fromJson(attendanceRecordJson))
          .toList(),
      marks: (json['marks'] as List)
          .map((markJson) => Mark.fromJson(markJson))
          .toList(),
      assignments: List<String>.from(json['assignments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'students': students.map((student) => student.toJson()).toList(),
      'attendanceRecords': attendanceRecords
          .map((attendanceRecord) => attendanceRecord.toJson())
          .toList(),
      'marks': marks.map((mark) => mark.toJson()).toList(),
      'assignments': assignments,
    };
  }
}
