import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyku/constant/state.dart';
import 'package:moneyku/model/task_model.dart';
import 'package:moneyku/screen/task/add_task_screen.dart';
import 'package:moneyku/screen/task/edit_task_screen.dart';
import 'package:moneyku/screen/task/task_view_model.dart';
import 'package:provider/provider.dart';
import 'package:transition/transition.dart';

import '../../theme.dart';
import '../../component/loading_screen.dart';

class Taskcreen extends StatefulWidget {
  const Taskcreen({Key? key}) : super(key: key);

  @override
  State<Taskcreen> createState() => _TaskcreenState();
}

class _TaskcreenState extends State<Taskcreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var viewModel = Provider.of<TaskViewModel>(context, listen: false);
      viewModel.getAllDataTask();
    });
  }

  Widget appBar() {
    return AppBar(
      title: const Text('Task'),
      centerTitle: true,
    );
  }

  Widget content() {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
            left: 20,
            right: 20,
          ),
          child: Consumer<TaskViewModel>(
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: value.allDataTask.length,
                itemBuilder: (context, index) {
                  return Card(
                    shadowColor: Colors.black,
                    child: ListTile(
                      onLongPress: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.QUESTION,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Yakin Hapus Data',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            value.deleteTask(
                                value.allDataTask[index].id!, index);
                          },
                        ).show();
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          Transition(
                              child: EditTaskScreen(
                                  model: TaskModel(
                                      id: value.allDataTask[index].id,
                                      title: value.allDataTask[index].title,
                                      price: value.allDataTask[index].price,
                                      status: value.allDataTask[index].status,
                                      deadline:
                                          value.allDataTask[index].deadline,
                                      userId: '')),
                              transitionEffect: TransitionEffect.RIGHT_TO_LEFT),
                        );
                      },
                      title: Text(
                        value.allDataTask[index].title,
                        style: primaryTextStyle.copyWith(),
                      ),
                      subtitle: Text(DateFormat('yyy-MM-dd')
                          .format(value.allDataTask[index].deadline)),
                      trailing: Text(NumberFormat.currency(
                              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                          .format(int.parse(value.allDataTask[index].price))),
                    ),
                  );
                },
              );
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, value, child) {
        if (value.state == StatusState.loding) {
          return const LoadingScreen();
        }
        return SafeArea(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                appBar(),
                content(),
                Center(
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      Transition(
                          child: AddTaskScreen(),
                          transitionEffect: TransitionEffect.RIGHT_TO_LEFT),
                    );
                  },
                  child: const Text('Tambah Task'),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
