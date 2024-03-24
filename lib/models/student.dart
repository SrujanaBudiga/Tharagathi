class Student {
  final String id;
  final String name;
  final String rollNumber;
  final String email;

  Student({
    required this.id,
    required this.name,
    required this.rollNumber,
    required this.email,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      rollNumber: json['rollNumber'],
      email: json['email'],
    );
  }

  get subjects => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rollNumber': rollNumber,
      'email': email,
    };
  }
}
