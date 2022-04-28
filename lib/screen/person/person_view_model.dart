import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonViewModel extends ChangeNotifier {
  bool readOnly = true;

  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', '');
    await prefs.setString('user', '');
    Navigator.pushReplacementNamed(context, '/sign');
  }
}
