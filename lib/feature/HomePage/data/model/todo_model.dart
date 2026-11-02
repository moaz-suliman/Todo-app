
class TasksResponse {
  List<TaskModel>? data;
  String? message;
  int? statusCode;
  bool? success;

  TasksResponse({
    this.data,
    this.message,
    this.statusCode,
    this.success,
  });

  TasksResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] is List) {
      data = <TaskModel>[];

      json['data'].forEach((v) {
        data!.add(TaskModel.fromJson(v));
      });
    }

    message = json['message'];
    statusCode = json['statusCode'];
    success = json['success'];
  }
}

class TaskModel {
  String? id;
  String? title;
  String? description;
  bool? isDone;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.isDone,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    isDone = json['isDone'];
  }
}
