import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rest_api/data/models/todo.dart';
import 'package:flutter_rest_api/data/repository/todo_repository.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  final todoRepository = TodoRepository();

  Future<void> fetchTodo() async {
    emit(TodoInitial());
    try {
      var todoList = await todoRepository.fetchTodos();
      emit(TodoLoaded(todoList!));
    } catch (e) {
      emit(TodoLoadingError(e.toString()));
    }
  }

  Future<void> deleteTodo(id) async {
    try {
      await todoRepository.removeTodo(id);
    } catch (e) {
      emit(TodoLoadingError(e.toString()));
    }
  }
}
