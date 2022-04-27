import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:moneyku/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget title() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 30,
        right: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi akil',
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
            'Rp. 300.000.0 00',
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
      ),
    );
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
      child: Column(
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
                      offset: const Offset(0, 3), // changes position of shadow
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
                      'Rp. 3.000.000',
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
                      offset: const Offset(0, 3), // changes position of shadow
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
                      'Rp. 3.000.000',
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
            'history',
            style: primaryTextStyle.copyWith(
              fontSize: 24,
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.INFO,
                    title: 'ucapan Selamat Natal bapeda 3x4',
                    desc: 'Oct 22, 2021',
                  ).show();
                },
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.arrow_upward,
                    color: Color(0xff3CAE5C),
                  ),
                  title: Text(
                    'ucapan Selamat Natal bapeda 3x4',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: primaryTextStyle.copyWith(fontSize: 18),
                  ),
                  subtitle: Text(
                    'Oct 22, 2021',
                    style: subtitleTextStyle.copyWith(fontSize: 11),
                  ),
                  trailing: Text(
                    '+ 10.000.000',
                    style: primaryTextStyle.copyWith(fontSize: 14),
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          )),
    );
  }
}
