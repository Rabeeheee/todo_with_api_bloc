class Todo {
  final int id;
  final String title;
  final String description;

  Todo({required this.id, required this.title, required this.description});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['_id'] ?? 0,
      title: json['title'] ?? 'No title', 
      description: json['description'] ?? 'No description', 
    );
  }
}
