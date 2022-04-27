import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:moneyku/screen/task/add_task_screen.dart';
import 'package:moneyku/screen/task/edit_task_screen.dart';
import 'package:transition/transition.dart';

import '../../theme.dart';

class Taskcreen extends StatelessWidget {
  const Taskcreen({Key? key}) : super(key: key);

  Widget appBar() {
    return AppBar(
      title: const Text('Todo List'),
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
        child: ListView.builder(
          itemCount: 10,
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
                    btnOkOnPress: () {},
                  ).show();
                },
                onTap: () {
                  Navigator.push(
                    context,
                    Transition(
                        child: EditTaskScreen(),
                        transitionEffect: TransitionEffect.LEFT_TO_RIGHT),
                  );
                },
                title: Text(
                  'Diesnatalis Universita Palangkaraya 3x5',
                  style: primaryTextStyle.copyWith(),
                ),
                subtitle: const Text('12 april 2021'),
                trailing: const Text('Rp 40.000'),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              child: const Text('Tambah Taks'),
            ))
          ],
        ),
      ),
    );
  }
}
