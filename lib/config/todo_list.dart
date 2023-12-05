import '../data/todo_model.dart';

class TodoList {
  static final List<TodoModel> _todos = [];
  static final List<TodoModel> _doneTodos = [];

  static List<TodoModel> get todos => _todos;

  static List<TodoModel> get doneTodos => _doneTodos;

  static void addTodo(TodoModel todo) {
    if (_todos.contains(todo)) return;
    _todos.add(todo);
  }

  static void editTodo(TodoModel oldTodo, TodoModel newTodo) {
    int index = _todos.indexOf(oldTodo);
    if (index != -1) {
      _todos[index] = newTodo;
    }
  }

  static void deleteTodo(TodoModel todo) {
    _todos.remove(todo);
  }


  static void deleteTodoTaskPage(TodoModel todo) {
    _todos.remove(todo);
  }

  static void addDoneTodo(TodoModel todo) {
    if (_doneTodos.contains(todo)) return;
    _doneTodos.add(todo);
  }

}
