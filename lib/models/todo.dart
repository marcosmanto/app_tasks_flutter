class Todo {
  final String title;
  final DateTime createdAt;

  Todo({required this.title, required this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
