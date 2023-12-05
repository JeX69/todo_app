import 'package:flutter/material.dart';
import '../config/todo_list.dart';
import '../data/todo_model.dart';
import '../widgets/info_card.dart';
import 'completed_page.dart';
import 'tasks_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  int currentPageIndex = 0;
  List<TodoModel> tempTodoList = TodoList.todos;

  void addTodo(TodoModel todo) {
    setState(() {
      tempTodoList.add(todo);
      TodoList.addTodo(todo);
    });
  }

  void doneTodo(TodoModel todo) {
    setState(() {
      tempTodoList.remove(todo);
      TodoList.addDoneTodo(todo.copyWith(isDone: true));
    });
  }

  void showInfoSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.45,
      ),
      builder: (context) {
        return Container(
          width: double.maxFinite,
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'TODO Tasks',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close, size: 18, color: Colors.black),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Row(
                    children: [
                      InfoCard(
                        label: TodoList.todos.length.toString(),
                        bgColor: Colors.blue,
                        textColor: Colors.white,
                        infoLabel: 'todo',
                      ),
                      InfoCard(
                        label: TodoList.doneTodos.length.toString(),
                        bgColor: Colors.blue,
                        textColor: Colors.white,
                        infoLabel: 'done',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration.zero);
    setState(() {
      tempTodoList = TodoList.todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
        centerTitle: true,
        leading: IconButton(
          iconSize: 28,
          icon: const Icon(Icons.info),
          onPressed: showInfoSheet,
        ),
        actions: [
          IconButton(
            iconSize: 28,
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: PageView(
          controller: pageController,
          onPageChanged: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          children: [
            TasksPage(
              todoList: tempTodoList,
              onTodoDone: doneTodo,
            ),
            const CompletedPage(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          final returnVal = await Navigator.pushNamed(context, '/new_task');

          if (returnVal != null) {
            addTodo(returnVal as TodoModel);
          }
        },
        child: const Icon(
          Icons.add_task_rounded,
          color: Colors.blueAccent,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          pageController.animateToPage(
            currentPageIndex,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
        elevation: 0.0,
        fixedColor: Colors.blueAccent,
        currentIndex: currentPageIndex,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.sticky_note_2_rounded),
            icon: Icon(Icons.sticky_note_2_outlined),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.task_rounded),
            icon: Icon(Icons.task_outlined),
            label: 'Completed',
          ),
        ],
      ),
    );
  }
}
