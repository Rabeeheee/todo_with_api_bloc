

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list_with_bloc/services/api_service.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ApiService apiService;

  TodoBloc(this.apiService) : super(TodoInitial()) {
    on<LoadTodos>(
      (event, emit) async {
        emit(TodoLoading());
        try {
          final todos = await apiService.fetchTodos();
          emit(TodoLoaded(todos: todos));
        } catch (e) {
          emit(TodoError(message: e.toString()));
        }
      },
    );

    on<AddTodo>(
      (event, emit) async {
        try {
          await apiService.addTodo(event.title, event.description);
          add(LoadTodos());
        } catch (e) {
          emit(TodoError(message: e.toString()));
        }
      },
    );

    on<DeleteTodo>((event, emit)async {
      try{
        await apiService.deleteTodo(event.id);
        add(LoadTodos());
      }catch(e){
        emit(TodoError(message: e.toString()));
      }
    },);
  }
}


