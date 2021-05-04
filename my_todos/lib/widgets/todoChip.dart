import 'package:flutter/material.dart';
import 'package:my_todos/variables.dart';

class TodoChip extends StatelessWidget {
  final int index;
  final Function onDeleted;
  TodoChip({@required this.index,@required this.onDeleted});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(
    label: Text(todos[index]),
    onDeleted: onDeleted
      ),
    );
  }
}
