import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

Future getStorage() async {
  final prefs = await SharedPreferences.getInstance();

  final String? _token = prefs.getString('token');
  Map<String, dynamic> decodeUser =
      json.decode(prefs.getString('user') as String);
  UserModel _user = UserModel.fromJson(decodeUser);

  return [_token, _user];
}
