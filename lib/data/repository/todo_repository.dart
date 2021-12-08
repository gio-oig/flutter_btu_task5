import 'package:dio/dio.dart';
import 'package:flutter_rest_api/data/models/todo.dart';

class TodoRepository {
  List<Todo>? todoList = [];
  Dio dio = Dio();

  Future<List<Todo>?>? fetchTodos() async {
    final response = await dio.get('http://10.0.2.2:8080/todos');
    if (response.statusCode == 200) {
      var loadedTodo = <Todo>[];
      response.data.forEach((todo) {
        Todo todoModel = Todo.fromJson(todo);
        loadedTodo.add(todoModel);
        todoList = loadedTodo;
        return todoList;
      });
    }
    return todoList;
  }

  Future<void> removeTodo(id) async {
    await dio.delete('http://10.0.2.2:8080/delete-todo/${id}');
  }
}
