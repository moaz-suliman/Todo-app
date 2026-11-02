import 'package:flutter/material.dart';
import 'package:todo_app/feature/HomePage/data/repository/todo_repository.dart';

class NewTaskProvider extends ChangeNotifier {
  final TodoRepository repository;

  NewTaskProvider(this.repository);

  bool isLoading = false;

  String error = '';

  Future<bool> addTask({
    required String title,
    required String description,
  }) async {
    if (title.trim().isEmpty) {
      error = 'Please enter a task title';
      notifyListeners();
      return false;
    }

    isLoading = true;
    error = '';
    notifyListeners();

    try {
      await repository.addTodo(
        title: title.trim(),
        description: description.trim(),
      );

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
