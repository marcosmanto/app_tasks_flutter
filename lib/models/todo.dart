class Todo {
  final String title;
  final DateTime createdAt;

  Todo({required this.title, required this.createdAt});

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        createdAt = DateTime.parse(json['createdAt']);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
