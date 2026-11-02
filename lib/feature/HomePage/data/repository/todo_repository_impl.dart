import 'dart:convert';
import 'package:todo_app/core/api_service.dart';
import 'package:todo_app/core/base_url.dart';
import 'package:todo_app/feature/HomePage/data/model/todo_model.dart';
import 'todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final ApiService apiService = ApiService();

  @override
  Future<TaskModel> addTodo({
    required String title,
    required String description,
  }) async {
    final response = await apiService.post(BaseUrl.toDo, {
      'title': title,
      'description': description,
    });

    final result = jsonDecode(response);
    return TaskModel.fromJson(result['data']);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await apiService.delete('${BaseUrl.toDo}/$id');
  }

  @override
  Future<List<TaskModel>> getTodo() async {
    final response = await apiService.get(BaseUrl.toDo);

    final result = jsonDecode(response);
    return TasksResponse.fromJson(result).data ?? [];
  }
}
