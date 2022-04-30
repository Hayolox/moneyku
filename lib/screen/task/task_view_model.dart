import 'package:flutter/cupertino.dart';
import 'package:moneyku/model/api/task_api.dart';
import 'package:moneyku/model/task_model.dart';
import '../../constant/state.dart';
import '../../future/toast_future.dart';

class TaskViewModel extends ChangeNotifier {
  DateTime dueDate = DateTime.now();
  final currenDate = DateTime.now();
  List<TaskModel> allDataTask = [];
  StatusState state = StatusState.loding;

  changeStatusState(StatusState s) {
    state = s;
    notifyListeners();
  }

  getAllDataTask() async {
    changeStatusState(StatusState.loding);
    try {
      var _getallDataTast = await TaskApi().getAllDataTask();
      List<TaskModel> _dataTask = [];
      for (var element in _getallDataTast) {
        _dataTask.add(TaskModel.fromJson(element));
      }
      allDataTask = _dataTask;
      changeStatusState(StatusState.none);
      notifyListeners();
    } catch (e) {
      changeStatusState(StatusState.error);
    }
  }

  editTask(TaskModel paramTask) async {
    try {
      await TaskApi().editTask(paramTask);
      toastInformation('Data Berhasil DiEdit');
    } catch (e) {
      toastAlert('Gagal Edit Data');
    }
  }

  deleteTask(int paramId, int paramIndex) async {
    try {
      await TaskApi().deleteTask(paramId);
      allDataTask.removeAt(paramIndex);
      notifyListeners();
    } catch (e) {
      toastAlert('Gagal delete Data');
    }
  }
}
