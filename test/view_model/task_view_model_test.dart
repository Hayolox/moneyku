import 'package:flutter_test/flutter_test.dart';
import 'package:moneyku/constant/state.dart';
import 'package:moneyku/model/task_model.dart';
import 'package:moneyku/screen/task/task_view_model.dart';

void main() {
  TaskViewModel _task = TaskViewModel();

  test('Test State Task', () {
    expect(_task.state, StatusState.loding);

    _task.changeStatusState(StatusState.error);
    expect(_task.state, StatusState.error);

    _task.changeStatusState(StatusState.none);
    expect(_task.state, StatusState.none);
  });

  group('Add And Get Data Task', () {
    test('Add Data Task', () async {
      await _task.getAllDataTask();
      int taskOld = _task.allDataTask.length;
      await _task.addTask(
        TaskModel(
            userId: '1',
            title: 'Task Unit Testing',
            price: '1000',
            deadline: DateTime.now(),
            status: 'process'),
        true,
      );

      await _task.getAllDataTask();
      int taskNew = _task.allDataTask.length;

      expect(taskNew > taskOld, true);
    });

    test('Get All Data Task', () async {
      await _task.getAllDataTask();
      expect(_task.allDataTask.isNotEmpty, true);
    });
  });
}
