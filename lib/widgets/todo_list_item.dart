import 'package:flutter/material.dart';

class TodoListItem extends StatelessWidget {
  final String title;
  final DateTime? createdDate;
  TodoListItem(this.title, [this.createdDate, Key? key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '23/12/2022',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w300,
              letterSpacing: .75,
            ),
          ),
          Text(
            title,
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
