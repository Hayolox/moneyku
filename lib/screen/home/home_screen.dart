import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyku/constant/state.dart';
import 'package:moneyku/component/loading_screen.dart';
import 'package:moneyku/screen/notes/notes_view_model.dart';
import 'package:moneyku/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var _viewModel = Provider.of<NotesViewModel>(context, listen: false);
      await _viewModel.getAllDataTransaction();
    });
  }

  Widget title() {
    return Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 30,
          right: 30,
        ),
        child: Consumer<NotesViewModel>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value.name,
                  style: whiteTextStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Welcome back!',
                  style: whiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                      .format(value.total),
                  style: whiteTextStyle.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Total Keuangan',
                  style: whiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            );
          },
        ));
  }

  Widget content() {
    return Container(
        padding: const EdgeInsets.only(
          top: 30,
          left: 30,
          right: 30,
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: whiteTextColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Consumer<NotesViewModel>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Keuangan',
                  style: primaryTextStyle.copyWith(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 17, bottom: 17),
                      height: 94,
                      width: 140,
                      decoration: BoxDecoration(
                        color: whiteTextColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Column(children: [
                          Text(
                            'Pemasukan',
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp ',
                                    decimalDigits: 0)
                                .format(int.parse(value.sumIncome)),
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              color: const Color(0xff3CAE5C),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 17, bottom: 17),
                      height: 94,
                      width: 140,
                      decoration: BoxDecoration(
                        color: whiteTextColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Column(children: [
                          Text(
                            'Pengeluaran',
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp ',
                                    decimalDigits: 0)
                                .format(int.parse(value.sumSpending)),
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              color: const Color(0xffFF4328),
                            ),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Transaksi',
                  style: primaryTextStyle.copyWith(
                    fontSize: 24,
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: value.allDataTransaction.length,
                  itemBuilder: (context, index) {
                    DateTime convertTimesToDate = DateTime.parse(
                        value.allDataTransaction[index].createdAt);
                    return GestureDetector(
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.INFO,
                          title: value.allDataTransaction[index].title,
                          desc: DateFormat('yyy-MM-dd')
                              .format(convertTimesToDate),
                        ).show();
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.arrow_upward,
                          color: Color(0xff3CAE5C),
                        ),
                        title: Text(
                          value.allDataTransaction[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: primaryTextStyle.copyWith(fontSize: 18),
                        ),
                        subtitle: Text(
                          DateFormat('yyy-MM-dd').format(convertTimesToDate),
                          style: subtitleTextStyle.copyWith(fontSize: 11),
                        ),
                        trailing: Text(
                          NumberFormat.currency(
                                  locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                              .format(int.parse(
                                  value.allDataTransaction[index].price)),
                          style:
                              value.allDataTransaction[index].status == 'income'
                                  ? primaryTextStyle.copyWith(
                                      fontSize: 14,
                                      color: Colors.green,
                                    )
                                  : primaryTextStyle.copyWith(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                        ),
                      ),
                    );
                  },
                ))
              ],
            );
          },
        ));
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
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  backroundColor1,
                  backroundColor2,
                  backroundColor3,
                  backroundColor4,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(),
                const SizedBox(
                  height: 30,
                ),
                Expanded(child: content()),
              ],
            ),
          ),
        );
      },
    );
  }
}
