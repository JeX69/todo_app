import 'package:flutter/material.dart';
import 'package:todo_app/data/todo_model.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  /// [_formKey] is used for validating form state
  final _formKey = GlobalKey<FormState>();
  final today = DateTime.now();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  String weekDayToDay(int index) {
    return days[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                    prefixIcon: Icon(
                      Icons.title,
                      color: Colors.blueAccent,
                    ),
                  ),
                  validator: (String? val) {
                    if (val == null || val == '') return 'Title is required!';
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _descriptionController,
                  minLines: 1,
                  maxLines: null,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                    prefixIcon: Icon(
                      Icons.description,
                      color: Colors.blueAccent
                    ),
                  ),
                  validator: (String? val) {
                    if (val == null || val == '') {
                      return 'Description is required!';
                    }
                    return null;
                  },
                ),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.5), // Add a shadow
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              width: 250,
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 50,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Selected Date',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${today.month} / ${today.year}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${today.day}',
                            style: const TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 3,
                        height: 80,
                        child: VerticalDivider(
                          color: Colors.white70,
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          weekDayToDay(today.weekday),
                          style: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final now = DateTime.now();
            final newTodo = TodoModel(
                _titleController.text,
                _descriptionController.text,
                '${today.day}/${today.month}/${today.year}',
                '${now.hour} : ${now.minute}');
            Navigator.pop(context, newTodo);
          }
        },
        icon: const Icon(Icons.add_task_rounded),
        label: const Text("Save"),
      ),
    );
  }
}