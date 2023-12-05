import 'package:flutter/material.dart';
import 'package:todo_app/data/todo_model.dart';
import '../config/todo_list.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key? key,
    required this.todo,
    this.onDone,
  }) : super(key: key);

  final TodoModel todo;
  final void Function()? onDone;

  void _editTodo(BuildContext context) async {
    final updatedTodo = await Navigator.pushNamed(
      context,
      '/edit_task',
      arguments: todo,
    );

    if (updatedTodo != null && updatedTodo is TodoModel) {
      TodoList.editTodo(todo, updatedTodo);
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                TodoList.deleteTodo(todo);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Task deleted'),
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(todo.isDone ? 14 : 6),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!todo.isDone) ...[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  _showDeleteConfirmationDialog(context);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(

                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  todo.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    todo.date,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    todo.time,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (!todo.isDone) ...[
                IconButton(
                  onPressed: () {
                    _editTodo(context);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),

                IconButton(

                  onPressed: onDone,
                  icon: const Icon(
                    Icons.task_alt,
                    color: Colors.white,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
