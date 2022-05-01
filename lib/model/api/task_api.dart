import 'package:dio/dio.dart';
import 'package:moneyku/model/task_model.dart';

class TaskApi {
  final _baseUrl = 'https://api.hizbullahhaidar.xyz/api/Taks';
  final _dio = Dio();

  Future getAllDataTask() async {
    final _response = await _dio.get(_baseUrl);

    if (_response.statusCode == 200) {
      return _response.data;
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future addTask(TaskModel task) async {
    final _response = await _dio.post(_baseUrl, data: {
      "user_id": task.userId,
      "title": task.title,
      "price": task.price,
      "deadline": task.deadline.toString(),
      "status": task.status
    });
    if (_response.statusCode == 200) {
      return _response;
    } else {
      throw Exception('Failed to edit data');
    }
  }

  Future editTask(TaskModel task) async {
    final _response = await _dio.put('$_baseUrl/' + task.id.toString(), data: {
      "user_id": task.userId,
      "title": task.title,
      "price": task.price,
      "deadline": task.deadline.toString(),
      "status": "process"
    });

    if (_response.statusCode == 200) {
      return _response;
    } else {
      throw Exception('Failed to edit data');
    }
  }

  Future deleteTask(int id) async {
    final _response = await _dio.delete('$_baseUrl/' + id.toString());
    if (_response.statusCode == 200) {
      return _response;
    } else {
      throw Exception('Failed to deleted data');
    }
  }
}
