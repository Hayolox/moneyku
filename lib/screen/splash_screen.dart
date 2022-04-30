import 'dart:async';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:moneyku/theme.dart';
import '../future/storage_future.dart';
import '../model/user_model.dart';

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
      () async {
        List _getDataStorage = await getStorage();
        String? _token = _getDataStorage[0];
        if (_token != null && _token.isNotEmpty) {
          UserModel _user = _getDataStorage[1];
          if (_user.roles == 'admin') {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            Navigator.pushReplacementNamed(context, '/home-employee');
          }
        } else {
          Navigator.pushReplacementNamed(context, '/sign');
        }
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

  getStorage() {}
}
