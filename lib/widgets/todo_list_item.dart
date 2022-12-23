import 'package:flutter/material.dart';
import '../utils/date_time_extension.dart';

import '../models/todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  TodoListItem(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 60,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            todo.createdAt.format('dd/MM/yyyy - EEEE', 'pt-BR').toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              letterSpacing: .75,
            ),
          ),
          Text(
            todo.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
