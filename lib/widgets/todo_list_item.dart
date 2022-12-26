import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../utils/date_time_extension.dart';

import '../models/todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  TodoListItem(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            extentRatio: .3,
            motion: ScrollMotion(),
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: null,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                icon: null,
                label: '',
              ),
              SlidableAction(
                flex: 12,
                spacing: 5,
                onPressed: null,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Excluir',
              ),
            ],
          ),
          child: Container(
            //height: 120,
            //margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: Colors.grey[600],
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      todo.createdAt
                          .format('dd/MM/yyyy, HH:mm - EEEE', 'pt-BR')
                          .toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        letterSpacing: .75,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 6),
                  child: Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
