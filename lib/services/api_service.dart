import 'dart:convert';
import 'dart:developer';

import 'package:todo_list_with_bloc/model/todo_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String url = 'https://api.nstack.in/v1/todos';

  Future addTodo(String title, String description) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization' : 'Bearer 2a6e5977-926f-4810-8c31-acd61b04666b',
        'Content-Type': 'application/json'},
      body: jsonEncode(
          {'title': title, 'description': description, 'is_completed': false}),
    );
    log(response.statusCode.toString());
    log(response.body);

    if (response.statusCode == 201) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add todo: ${response.body}');
    }
  }

  Future<List> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse(url),headers: {
        'Authorization' : 'Bearer 2a6e5977-926f-4810-8c31-acd61b04666b',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        log(response.body);
        final todoJson = jsonDecode(response.body) as Map;

        final result = todoJson['items'] as List;
        return result;
      } else {
        throw Exception('Failed to load todos:${response.body}');
      }
    } catch (e) {
      throw Exception('NetWork error: $e');
    }
  }

  Future deleteTodo(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      log(response.statusCode.toString());
    }
  }
}
