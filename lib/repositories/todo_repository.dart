import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

class TodoRepository {
  late final SharedPreferences sharedPreferences;

  TodoRepository() {
    SharedPreferences.getInstance()
        .then((instance) => sharedPreferences = instance);
  }

  void saveTodoList(List<Todo> todos) {
    final String jsonString = json.encode(todos);
    sharedPreferences.setString('todo_list', jsonString);
  }
}
