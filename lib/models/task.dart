import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  bool completed;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.completed});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        completed: json["completed"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed
    };
  }

  static List<Map<String, dynamic>> toJsonList(List<Task> tasks) {
    return tasks.map((task) => task.toJson()).toList();
  }
}