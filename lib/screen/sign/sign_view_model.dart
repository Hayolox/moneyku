import 'package:flutter/cupertino.dart';

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
}
