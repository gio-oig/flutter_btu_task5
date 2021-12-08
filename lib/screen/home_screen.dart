import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rest_api/logic/todo_cubit/cubit/todo_cubit.dart';
import 'package:flutter_rest_api/widgets/custom_input.dart';
import 'package:flutter_rest_api/widgets/list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        bloc: context.read<TodoCubit>()..fetchTodo(),
        builder: (context, state) {
          if (state is TodoInitial) {
            return const CircularProgressIndicator();
          } else if (state is TodoLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const CustomInput(),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final todo = state.todoList[index];
                        return ListItem(
                          title: todo.todo!,
                          subtitle: todo.description!,
                          onClick: () =>
                              context.read<TodoCubit>().deleteTodo(todo.id),
                        );
                      },
                      itemCount: state.todoList.length,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text((state as TodoLoadingError).errorMessage),
            );
          }
        },
      ),
    );
  }
}
