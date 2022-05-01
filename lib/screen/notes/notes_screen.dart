import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyku/model/transaction_model.dart';
import 'package:moneyku/screen/notes/add_%20expenditure_screen.dart';
import 'package:moneyku/screen/notes/add_income_screen.dart';
import 'package:moneyku/screen/notes/edit_notes_screen.dart';
import 'package:moneyku/screen/notes/notes_view_model.dart';
import 'package:moneyku/theme.dart';
import 'package:provider/provider.dart';
import 'package:transition/transition.dart';
import '../../constant/state.dart';
import '../../component/loading_screen.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var viewModel = Provider.of<NotesViewModel>(context, listen: false);
      await viewModel.getStatusTransaction();
    });
  }

  Widget income(BuildContext context) {
    return Consumer<NotesViewModel>(
      builder: (context, value, child) {
        return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: value.incomeDataTransaction.length,
                    itemBuilder: (context, index) {
                      DateTime convertTimesToDate = DateTime.parse(
                          value.incomeDataTransaction[index].createdAt);
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
                                value.deleteTransaction(
                                    value.incomeDataTransaction[index].id
                                        .toString(),
                                    index,
                                    value.incomeDataTransaction[index].status);
                              },
                            ).show();
                          },
                          onTap: () {
                            Navigator.push(
                              context,
                              Transition(
                                  child: EditNotesScreen(
                                      model: TransactionModel(
                                          id: value
                                              .incomeDataTransaction[index].id,
                                          title: value
                                              .incomeDataTransaction[index]
                                              .title,
                                          price: value
                                              .incomeDataTransaction[index]
                                              .price,
                                          status: value
                                              .incomeDataTransaction[index]
                                              .status,
                                          createdAt: value
                                              .incomeDataTransaction[index]
                                              .createdAt)),
                                  transitionEffect:
                                      TransitionEffect.RIGHT_TO_LEFT),
                            );
                          },
                          title: Text(
                            value.incomeDataTransaction[index].title,
                            style: primaryTextStyle.copyWith(),
                          ),
                          subtitle: Text(
                            DateFormat('yyy-MM-dd').format(convertTimesToDate),
                          ),
                          trailing: Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            ).format(int.parse(
                                value.incomeDataTransaction[index].price)),
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
      },
    );
  }

  Widget expenditure(BuildContext context) {
    return Consumer<NotesViewModel>(
      builder: (context, value, child) {
        return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: value.spendingDataTransaction.length,
                    itemBuilder: (context, index) {
                      DateTime convertTimesToDate = DateTime.parse(
                          value.spendingDataTransaction[index].createdAt);
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
                                value.deleteTransaction(
                                    value.spendingDataTransaction[index].id
                                        .toString(),
                                    index,
                                    value
                                        .spendingDataTransaction[index].status);
                              },
                            ).show();
                          },
                          onTap: () {
                            Navigator.push(
                              context,
                              Transition(
                                  child: EditNotesScreen(
                                      model: TransactionModel(
                                          id: value
                                              .spendingDataTransaction[index]
                                              .id,
                                          title: value
                                              .spendingDataTransaction[index]
                                              .title,
                                          price: value
                                              .spendingDataTransaction[index]
                                              .price,
                                          status: value
                                              .spendingDataTransaction[index]
                                              .status,
                                          createdAt: value
                                              .spendingDataTransaction[index]
                                              .createdAt)),
                                  transitionEffect:
                                      TransitionEffect.RIGHT_TO_LEFT),
                            );
                          },
                          title: Text(
                            value.spendingDataTransaction[index].title,
                            style: primaryTextStyle.copyWith(),
                          ),
                          subtitle: Text(
                            DateFormat('yyy-MM-dd').format(convertTimesToDate),
                          ),
                          trailing: Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp ',
                                    decimalDigits: 0)
                                .format(int.parse(value
                                    .spendingDataTransaction[index].price)),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesViewModel>(
      builder: (context, value, child) {
        if (value.state == StatusState.loding) {
          return const LoadingScreen();
        }
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 30, left: 30, top: 30),
            width: double.infinity,
            child: Column(
              children: [
                const TabBar(
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.arrow_downward,
                        color: Colors.green,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.arrow_upward,
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
      },
    );
  }
}
