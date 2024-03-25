import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/feature/todo/domain/model/todo_model.dart';
import 'package:todo/feature/todo/domain/repository/local_database_repository.dart';
part 'local_database_repo_imp.g.dart';

class LocalDatabaseRepoImp implements ILocalDatabaseRepository {
  final String _boxName = "boxx";

  Future<Box<TodoModel>> _box() async => Hive.openBox(_boxName);

  /*-------------- Methods -----------------*/

  @override
  Future<List<TodoModel>> getAllTodos() async {
    final box = await _box();
    final todoList = box.values.toList();
    return todoList;
  }

  @override
  Future<void> addToBox({required TodoModel todo}) async {
    final box = await _box();
    await box.add(TodoModel(
        title: todo.title,
        description: todo.description,
        time: todo.time,
        backgroundColor: todo.backgroundColor,
        isCompleted: todo.isCompleted,
        date: todo.date,
        id: todo.id));
  }

  @override
  Future<void> deleteTodoFromBox(int index) async {
    final box = await _box();
    box.deleteAt(index);
  }

  @override
  Future<void> updateComplete(TodoModel todo) async {
    final box = await _box();
    todo.isCompleted = !todo.isCompleted;
    box.putAt(box.values.toList().indexOf(todo), todo);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    // final box = await _box();
    todo.save();
    // box.putAt(box.values.toList().indexOf(todo), todo);
  }
}

@Riverpod(keepAlive: true)
LocalDatabaseRepoImp localDatabaseRepoImp(LocalDatabaseRepoImpRef ref) {
  return LocalDatabaseRepoImp();
}
