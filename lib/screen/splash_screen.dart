import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:moneyku/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // ignore: must_call_super
  void initState() {
    // ignore: todo
    // TODO: implement initState
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacementNamed(context, '/sign');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DelayedDisplay(
          delay: const Duration(seconds: 1),
          child: Text("WELCOME",
              style: primaryTextStyle.copyWith(
                fontSize: 50,
              )),
        ),
      ),
    );
  }
}
