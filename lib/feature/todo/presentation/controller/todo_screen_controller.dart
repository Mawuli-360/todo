import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/feature/todo/application/todo_service.dart';
import 'package:todo/feature/todo/domain/model/todo_model.dart';
part 'todo_screen_controller.g.dart';

@riverpod
class TodoScreenController extends _$TodoScreenController {
  @override
  FutureOr<List<TodoModel>> build() async {
    List<TodoModel> todos =
        await ref.watch(todoServiceProvider).fetchAllTodos();

    return todos;
  }

  /*-------------METHODS------------*/

  Future<void> delete(int index) async {
    ref.watch(todoServiceProvider).delete(index);
    final todos = await ref.watch(todoServiceProvider).fetchAllTodos();
    state = AsyncData(todos);
  }

  Future<void> addTodo(TodoModel todo) async {
    ref.watch(todoServiceProvider).addToBox(todo: todo);
    final todos = await ref.watch(todoServiceProvider).fetchAllTodos();
    state = AsyncData(todos);
  }

  Future<void> updateComplete(TodoModel todo) async {
    ref.watch(todoServiceProvider).updateComplete(todo: todo);
    final todos = await ref.watch(todoServiceProvider).fetchAllTodos();
    state = AsyncData(todos);
  }

  Future<void> updateTodo(TodoModel todo) async {
    ref.watch(todoServiceProvider).updateTodo(todo: todo);
    final todos = await ref.watch(todoServiceProvider).fetchAllTodos();
    state = AsyncData(todos);
  }
}

@riverpod
class DateTimeChange extends _$DateTimeChange {
  @override
  String build() {
    return DateFormat.yMd().format(DateTime.now());
  }

  void changeDateTime(DateTime selectedDate) {
    String formattedDate = DateFormat.yMd().format(selectedDate);
    state = formattedDate;
  }
}
