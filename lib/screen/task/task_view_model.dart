import 'package:flutter/material.dart';
import 'package:moneyku/model/api/task_api.dart';
import 'package:moneyku/model/task_model.dart';
import 'package:moneyku/model/transaction_model.dart';
import 'package:moneyku/screen/notes/notes_view_model.dart';
import '../../constant/state.dart';
import '../../future/toast_future.dart';

class TaskViewModel extends ChangeNotifier {
  DateTime dueDate = DateTime.now();
  final currenDate = DateTime.now();

  TextEditingController titleC = TextEditingController();
  TextEditingController priceC = TextEditingController();

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

  addTask(TaskModel paramTask) async {
    try {
      await TaskApi().addTask(paramTask);
      titleC.clear();
      priceC.clear();
      dueDate = DateTime.now();
      toastInformation('Data Berhasil Ditambahkan');
      notifyListeners();
    } catch (e) {
      toastAlert('Gagal Add Data');
    }
  }

  editTask(TaskModel paramTask, String paramRole, int paramIndex) async {
    try {
      await TaskApi().editTask(paramTask);

      /// conditional role employee
      if (paramRole == 'employee') {
        NotesViewModel().addTransaction(
          TransactionModel(
              title: paramTask.title,
              price: paramTask.price,
              status: 'income',
              createdAt: DateTime.now().toString()),
          paramRole,
        );
        allDataTask.removeAt(paramIndex);
        notifyListeners();
        toastInformation('Task Selesai');
      } else {
        toastInformation('Data Berhasil Diedit');
      }
    } catch (e) {
      toastAlert('Gagal Edit Data');
    }
  }

  deleteTask(int paramId, int paramIndex) async {
    try {
      await TaskApi().deleteTask(paramId);
      allDataTask.removeAt(paramIndex);
      notifyListeners();
      toastInformation('Data Berhasil Dihapus');
    } catch (e) {
      toastAlert('Gagal delete Data');
    }
  }

  Future<void> showDate(BuildContext context) async {
    final selectDate = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime(currenDate.year),
      lastDate: DateTime(currenDate.year + 1),
    );
    dueDate = selectDate!;
    notifyListeners();
  }
}
