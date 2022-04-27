import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:moneyku/theme.dart';

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
        child: ListView.builder(
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
                    btnOkOnPress: () {},
                  ).show();
                },
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.INFO,
                    title: 'ucapan Selamat Natal bapeda 3x4',
                    desc: 'Deadline : 12 januari 2022',
                  ).show();
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
}
