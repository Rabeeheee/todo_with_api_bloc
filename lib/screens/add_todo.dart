import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_with_bloc/fonts/fonts.dart';
import 'package:todo_list_with_bloc/todo_bloc/todo_bloc.dart';

class AddingTodo extends StatelessWidget {
  AddingTodo({super.key});
  
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Add Todo',
            style: headLine,
          ),
        ),
        body: Form(
          key: formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 8,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
           ElevatedButton(
  onPressed: () {
    if (formKey.currentState?.validate() ?? false) {
      context.read<TodoBloc>().add(AddTodo(
        title: titleController.text,
        description: descriptionController.text,
      ));
      Navigator.of(context).pop();
    }
  },
  child: const Text(
    'Save',
    style: TextStyle(
      color: Color.fromARGB(255, 210, 210, 210),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 34, 34, 34),
    padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 24),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), 
    ),
    elevation: 5, 
  ),
)

          ]),
        ),
      ),
    );
  }
}
