class Assignment {
  final String id;
  final String title;
  final String description;
  final String url;
  final DateTime dueDate;
  final List<String> submittedBy;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.dueDate,
    required this.submittedBy,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      dueDate: DateTime.parse(json['dueDate']),
      submittedBy: List<String>.from(json['submittedBy']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'dueDate': dueDate.toIso8601String(),
      'submittedBy': submittedBy,
    };
  }
}
