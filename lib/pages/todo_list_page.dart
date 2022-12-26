import 'package:app_tasks_flutter/models/todo.dart';
import 'package:app_tasks_flutter/utils/clear_focus.dart';
import 'package:app_tasks_flutter/widgets/todo_list_item.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoIndex;

  void addTask() {
    if (todoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[600],
          content: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              const Text(
                'Você precisa adicionar um título à tarefa.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
      return;
    }

    setState(
      () => todos.add(
        Todo(
          title: todoController.text,
          createdAt: DateTime.now(),
        ),
      ),
    );
    todoController.clear();
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoIndex = todos.indexOf(todo);

    setState(() => todos.remove(todo));

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 10),
        backgroundColor: Colors.white,
        action: SnackBarAction(
            label: 'Desfazer',
            textColor: const Color(0xFF00d7f3),
            onPressed: () =>
                setState(() => todos.insert(deletedTodoIndex!, deletedTodo!))),
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              //size: 14,
            ),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                'Tarefa "${todo.title}" foi removida com sucesso',
                overflow: TextOverflow.fade,
                style: TextStyle(color: Colors.black),
                //maxLines: 3,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClearFocus(
        child: Scaffold(
          body: Center(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: todoController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Adicione uma tarefa',
                            floatingLabelStyle:
                                TextStyle(color: Color(0xFF00D7F3)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF00D7F3),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                          onPressed: addTask,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF00D7F3),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 30,
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo,
                          onDelete: onDelete,
                        )
                    ],
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                            'Você possui ${todos.length} tarefas pendentes')),
                    SizedBox(width: 8),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00D7F3),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                        ),
                        child: Text('Limpar tudo'))
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
