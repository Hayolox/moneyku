import 'dart:async';
import 'dart:convert';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:moneyku/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        final prefs = await SharedPreferences.getInstance();

        final String? _token = prefs.getString('token');

        if (_token != null && _token.isNotEmpty) {
          Map<String, dynamic> decodeUser =
              json.decode(prefs.getString('user') as String);
          UserModel _user = UserModel.fromJson(decodeUser);
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
}
