import 'package:app_tasks_flutter/models/todo.dart';
import 'package:app_tasks_flutter/repositories/todo_repository.dart';
import 'package:app_tasks_flutter/utils/clear_focus.dart';
import 'package:app_tasks_flutter/widgets/todo_list_item.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF00D7F3);

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoIndex;

  @override
  void initState() {
    super.initState();
    todoRepository
        .getTodoList()
        .then((savedTodos) => setState(() => todos = savedTodos));
  }

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
      () => todos = todos
        ..add(
          Todo(
            title: todoController.text,
            createdAt: DateTime.now(),
          ),
        )
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
    );
    todoController.clear();
    todoRepository.saveTodoList(todos);
  }

  void deleteAllTodos() {
    setState(() => todos.clear());
    todoRepository.saveTodoList(todos);
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Limpar tudo?'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                      'Você tem certeza que deseja apagar todas as tarefas?'),
                  const SizedBox(height: 10),
                  const Text(
                    'Essa ação não poderá ser desfeita.',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                  ),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    deleteAllTodos();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red[600],
                  ),
                  child: const Text('Limpar tudo'),
                ),
              ],
            ));
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoIndex = todos.indexOf(todo);

    setState(() => todos.remove(todo));

    todoRepository.saveTodoList(todos);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 10),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: primaryColor,
          onPressed: () {
            setState(() => todos.insert(deletedTodoIndex!, deletedTodo!));
            todoRepository.saveTodoList(todos);
          },
        ),
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
                          onSubmitted: (_) => addTask(),
                          controller: todoController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Adicione uma tarefa',
                            floatingLabelStyle: TextStyle(color: primaryColor),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                          onPressed: addTask,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
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
                        onPressed: showDeleteTodosConfirmationDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
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
