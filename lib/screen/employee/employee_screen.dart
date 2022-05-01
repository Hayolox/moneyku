import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyku/component/loading_screen.dart';
import 'package:moneyku/constant/state.dart';
import 'package:moneyku/screen/task/task_view_model.dart';
import 'package:moneyku/theme.dart';
import 'package:provider/provider.dart';

import '../../future/storage_future.dart';
import '../../model/task_model.dart';
import '../../model/user_model.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.only(
            top: 30,
            left: 30,
            right: 30,
          ),
          child: Consumer<TaskViewModel>(
            builder: (context, value, child) {
              if (value.state == StatusState.loding) {
                return const Center(
                  child: LoadingScreen(),
                );
              }
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
                          title: 'Yakin Task Seleai?',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () async {
                            List _getDataStorage = await getStorage();
                            UserModel user = _getDataStorage[1];

                            value.editTask(
                                TaskModel(
                                  id: value.allDataTask[index].id,
                                  title: value.allDataTask[index].title,
                                  price: value.allDataTask[index].price,
                                  status: 'done',
                                  deadline: value.allDataTask[index].deadline,
                                  userId: user.id.toString(),
                                ),
                                user.roles,
                                index);
                          },
                        ).show();
                      },
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.INFO,
                          title: value.allDataTask[index].title,
                          desc:
                              'dateline : ${DateFormat('yyy-MM-dd').format(value.allDataTask[index].deadline)}',
                        ).show();
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
}
