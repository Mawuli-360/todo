import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/feature/todo/data/local_database_repo_imp.dart';
import 'package:todo/feature/todo/domain/model/todo_model.dart';
part 'todo_service.g.dart';

class TodoService {
  TodoService(this.ref);

  final Ref ref;


  Future<List<TodoModel>> fetchAllTodos() async {
    final todos = await ref.read(localDatabaseRepoImpProvider).getAllTodos();
    List<TodoModel> todoList = [];
    todoList = todos;
    return todoList;
  }


  Future<void> delete(int index) async {
    ref.watch(localDatabaseRepoImpProvider).deleteTodoFromBox(index);
  }

  Future<void> addToBox({required TodoModel todo}) async {
    final repository = ref.watch(localDatabaseRepoImpProvider);
    repository.addToBox(todo: todo);
  }

  Future<void> updateComplete({required TodoModel todo}) async{
   ref.watch(localDatabaseRepoImpProvider).updateComplete(todo);
  }

  Future<void> updateTodo({required TodoModel todo}) async {
    ref.watch(localDatabaseRepoImpProvider).updateTodo(todo);
  }
}

@riverpod
TodoService todoService(TodoServiceRef ref) {
  return TodoService(ref);
}


