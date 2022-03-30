import 'dart:convert';

class Todo {
  final String title;
  final bool completed;

  Todo({
    required this.title,
    required this.completed,
  });

  Todo copyWith({
    String? title,
    bool? completed,
  }) {
    return Todo(
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'completed': completed,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] ?? '',
      completed: map['completed'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() => 'Todo(title: $title, completed: $completed)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo && other.title == title && other.completed == completed;
  }

  @override
  int get hashCode => title.hashCode ^ completed.hashCode;
}
