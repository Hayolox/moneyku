import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:moneyku/model/api/user_api.dart';
import 'package:moneyku/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignViewModel extends ChangeNotifier {
  bool isHideen = true;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  void changeIsHidden(bool paramIsHidden) {
    if (paramIsHidden == true) {
      isHideen = false;
    } else {
      isHideen = true;
    }
    notifyListeners();
  }

  void sign(
      String paramName, String paramPassword, BuildContext context) async {
    try {
      /// api
      Map<String, dynamic> _allDataUser =
          await UserApi().getDataUser(paramName, paramPassword);
      String _token = _allDataUser['token'];
      UserModel _user = UserModel.fromJson(_allDataUser['user']);

      /// Storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token);
      await prefs.setString('user', json.encode(_user));

      /// clear emailC and PasswordC
      emailC.clear();
      passwordC.clear();

      /// Conditional
      if (_user.roles == 'admin') {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/home-employee');
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Email atau Password Salah",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
