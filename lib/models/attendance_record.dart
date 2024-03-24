class AttendanceRecord {
  final String id;
  final String studentId;
  final String className;
  final String subject;
  final DateTime date;
  final bool isPresent;

  AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.className,
    required this.subject,
    required this.date,
    required this.isPresent,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'],
      studentId: json['studentId'],
      className: json['className'],
      subject: json['subject'],
      date: DateTime.parse(json['date']),
      isPresent: json['isPresent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'className': className,
      'subject': subject,
      'date': date.toIso8601String(),
      'isPresent': isPresent,
    };
  }
}
