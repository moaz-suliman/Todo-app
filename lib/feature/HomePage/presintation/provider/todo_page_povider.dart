import 'package:flutter/material.dart';
import 'package:todo_app/feature/HomePage/data/model/todo_model.dart';
import '../../data/repository/todo_repository.dart';

class TodoPagePovider extends ChangeNotifier {
  final TodoRepository repository;



  String selectedFilter='All';
  void changeSelectedFilter(String value){
    selectedFilter=value;
    notifyListeners();

  }

  TodoPagePovider(this.repository);

  List<TaskModel> tasks = [];

  bool isLoading = false;

  String error = '';

  Future<void> getTasks() async {
    isLoading = true;
    error = '';
    notifyListeners();

    try {
      tasks = await repository.getTodo();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> removeTask(int index) async {
    final task = tasks[index];

    try {
      await repository.deleteTodo(task.id!);
      tasks.removeAt(index);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  void toggleTaskCompletion(int index) {
    tasks[index].isDone = !(tasks[index].isDone ?? false);
    notifyListeners();
  }

  Color stateColor(String state) {
    if (state == 'low') return Colors.green;
    if (state == 'high') return Colors.red;
    return Colors.blue;
  }
}