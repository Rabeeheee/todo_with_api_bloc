import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_with_bloc/screens/home_screen.dart';
import 'package:todo_list_with_bloc/services/api_service.dart';
import 'package:todo_list_with_bloc/todo_bloc/todo_bloc.dart';

void main() {
  final ApiService apiService = ApiService();
  runApp(MyApp(
    apiService: apiService,
  ));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;
  const MyApp({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(apiService)..add(LoadTodos()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        ),
      );
    
  }
}
