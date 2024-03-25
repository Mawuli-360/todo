import 'package:todo/feature/todo/domain/model/todo_model.dart';

class TodoScreenState {
  final List<TodoModel> todos;
  final DateTime date;

  TodoScreenState({required this.date, required this.todos});

  TodoScreenState.initial()
      : date = DateTime.now(),
        todos = [];

  TodoScreenState copyWith({DateTime? date, List<TodoModel>? todos}) {
    return TodoScreenState(date: date ?? this.date, todos: todos ?? this.todos);
  }
}
