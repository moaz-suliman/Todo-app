
import 'package:todo_app/feature/HomePage/data/model/todo_model.dart';

abstract class TodoRepository {
  Future<TaskModel> addTodo({
    required String title,
    required String description,
  });

  Future<void> deleteTodo(String id);

  Future<List<TaskModel>> getTodo();
}