import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneyku/model/api/user_api.dart';
import 'package:moneyku/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../future/toast_future.dart';

class PersonViewModel extends ChangeNotifier {
  bool readOnly = true;

  get prefs => null;

  editUser(UserModel paramUser) async {
    try {
      await UserApi().editDataUser(paramUser);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(paramUser));
      toastInformation('Data Berhasil Diedit');
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Email sudah digunakan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', '');
    await prefs.setString('user', '');
    Navigator.pushReplacementNamed(context, '/sign');
  }
}
