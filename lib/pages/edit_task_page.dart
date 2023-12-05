import 'package:flutter/material.dart';
import 'package:todo_app/data/todo_model.dart';

class EditTaskPage extends StatefulWidget {
  final TodoModel todo;

  const EditTaskPage({Key? key, required this.todo}) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todo.title;
    descriptionController.text = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Edit Title:'),
            TextFormField(
              controller: titleController,
            ),
            const SizedBox(height: 16),
            const Text('Edit Description:'),
            TextFormField(
              controller: descriptionController,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.todo.title = titleController.text;
                widget.todo.description = descriptionController.text;
                Navigator.pop(context, widget.todo);
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
