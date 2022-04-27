import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:moneyku/screen/notes/add_%20expenditure_screen.dart';
import 'package:moneyku/screen/notes/add_income_screen.dart';
import 'package:moneyku/screen/notes/edit_task_screen.dart';
import 'package:moneyku/theme.dart';
import 'package:transition/transition.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  Widget income(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
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
                              child: EditNotesScreen(),
                              transitionEffect: TransitionEffect.RIGHT_TO_LEFT),
                        );
                      },
                      title: Text(
                        'Diesnatalis Universita Palangkaraya 3x5',
                        style: primaryTextStyle.copyWith(),
                      ),
                      subtitle: const Text(
                        '12 april 2021',
                      ),
                      trailing: Text(
                        '+ Rp 40.000',
                        style: primaryTextStyle.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  Transition(
                      child: AddIncomeScreen(),
                      transitionEffect: TransitionEffect.RIGHT_TO_LEFT),
                );
              },
              child: const Text('Tambah Pemasukan'),
            ))
          ],
        ));
  }

  Widget expenditure(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
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
                              child: EditNotesScreen(),
                              transitionEffect: TransitionEffect.RIGHT_TO_LEFT),
                        );
                      },
                      title: Text(
                        'Diesnatalis Universita Palangkaraya 3x5',
                        style: primaryTextStyle.copyWith(),
                      ),
                      subtitle: const Text(
                        '12 april 2021',
                      ),
                      trailing: Text(
                        '- Rp 40.000',
                        style: primaryTextStyle.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  Transition(
                      child: AddExpenditureScreen(),
                      transitionEffect: TransitionEffect.RIGHT_TO_LEFT),
                );
              },
              child: const Text('Tambah Pengeluaran'),
            ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            const TabBar(
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.arrow_downward,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                income(context),
                expenditure(context),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
