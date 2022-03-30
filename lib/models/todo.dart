import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final bool completed;

  Todo({
    required this.title,
    required this.completed,
  });
}
