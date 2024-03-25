import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel extends HiveObject {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String description;
  @HiveField(2)
  late String time;
  @HiveField(3)
  late int backgroundColor;
  @HiveField(4)
  bool isCompleted;
  @HiveField(5)
  late String date;
  @HiveField(6)
  late int id;

  TodoModel({
    required this.title,
    required this.description,
    required this.time,
    required this.backgroundColor,
    this.isCompleted = false,
    required this.date,
    required this.id,
  });
}
