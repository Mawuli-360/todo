import 'package:todo/feature/todo/domain/model/todo_model.dart';

abstract class ILocalDatabaseRepository {
  Future<List<TodoModel>> getAllTodos();
  Future<void> addToBox({required TodoModel todo});
  Future<void> deleteTodoFromBox(int index);
  Future<void> updateComplete(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);

}



