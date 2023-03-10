import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../utils/date_time_extension.dart';

import '../models/todo.dart';

class TodoListItem extends StatefulWidget {
  final Todo todo;
  final void Function(Todo) onDelete;
  const TodoListItem(this.todo, {required this.onDelete, super.key});

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!kIsWeb)
          Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              extentRatio: .3,
              motion: const ScrollMotion(),
              children: [
                // A SlidableAction can have an icon and/or a label.
                const SlidableAction(
                  onPressed: null,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  icon: null,
                  label: '',
                ),
                SlidableAction(
                  flex: 12,
                  spacing: 5,
                  onPressed: (_) => widget.onDelete(widget.todo),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  backgroundColor: const Color(0xFFFE4A49),
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
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        widget.todo.createdAt
                            .format('dd/MM/yyyy, HH:mm - EEEE', 'pt-BR')
                            .toUpperCase(),
                        style: const TextStyle(
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
                      widget.todo.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (kIsWeb)
          IntrinsicHeight(
            child: MouseRegion(
              onEnter: (_) {
                setState(() => isHover = true);
              },
              onExit: (_) => setState(() => isHover = false),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      //height: 120,
                      //margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
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
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                widget.todo.createdAt
                                    .format('dd/MM/yyyy, HH:mm - EEEE', 'pt-BR')
                                    .toUpperCase(),
                                style: const TextStyle(
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
                              widget.todo.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (isHover)
                    InkWell(
                      onTap: () => widget.onDelete(widget.todo),
                      child: Container(
                        width: 75,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              Text('Excluir',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700))
                            ]),
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
