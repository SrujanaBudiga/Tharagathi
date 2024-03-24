class Mark {
  final String id;
  final String studentId;
  final String className;
  final String subject;
  final double score;

  Mark copyWith({double? score}) {
    return Mark(
      id: id,
      studentId: studentId,
      className: className,
      subject: subject,
      score: score ?? this.score,
    );
  }

  Mark({
    required this.id,
    required this.studentId,
    required this.className,
    required this.subject,
    required this.score,
  });

  factory Mark.fromJson(Map<String, dynamic> json) {
    return Mark(
      id: json['id'],
      studentId: json['studentId'],
      className: json['className'],
      subject: json['subject'],
      score: json['score'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'className': className,
      'subject': subject,
      'score': score,
    };
  }
}
