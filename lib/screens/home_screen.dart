import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_with_bloc/fonts/fonts.dart';
import 'package:todo_list_with_bloc/screens/add_todo.dart';
import 'package:todo_list_with_bloc/todo_bloc/todo_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('ToDo List', style: headLine),
          
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(255, 251, 251, 251),
                ),
              );
            } else if (state is TodoLoaded) {
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                    decoration: BoxDecoration(
                      color:  Color.fromARGB(255, 34, 34, 34),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: ListTile(
                      title: Text(state.todos[index]['title'],style:const TextStyle(color: Color.fromARGB(255, 229, 229, 229)),),
                      subtitle: Text(state.todos[index]['description'],style:const TextStyle(color: Color.fromARGB(255, 157, 157, 157)),),
                      trailing: IconButton(
                          onPressed: () {
                            context
                                .read<TodoBloc>()
                                .add(DeleteTodo(state.todos[index]['_id']));
                          },
                          icon: const Icon(Icons.delete,color: Color.fromARGB(255, 254, 0, 0),)),
                          
                    ),
                  );
                },
              );
            } else if (state is TodoError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('No Todos'),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddingTodo()));
          },
          label: const Text(
            'Add',
            style: TextStyle(color: Color.fromARGB(255, 222, 222, 222),fontSize: 17),
          ),
          backgroundColor: const Color.fromARGB(255, 34, 34, 34),
        ),
      ),
    );
  }
}

