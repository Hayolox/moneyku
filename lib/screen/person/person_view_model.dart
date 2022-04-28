import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonViewModel extends ChangeNotifier {
  bool readOnly = true;

  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('key');
    await prefs.remove('user');
    Navigator.pushReplacementNamed(context, '/sign');
  }
}
