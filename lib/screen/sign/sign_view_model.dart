import 'package:flutter/cupertino.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';

class SignViewModel extends ChangeNotifier {
  bool isHideen = true;

  void changeIsHidden(bool paramIsHidden) {
    if (paramIsHidden == true) {
      isHideen = false;
    } else {
      isHideen = true;
    }
    notifyListeners();
  }

  Object validation(
    String paramEmail,
    String paramPassword,
    BuildContext context,
  ) {
    if (paramEmail.isEmpty && paramPassword.isEmpty) {
      return seeDialog(
          'Email & Password  tidak boleh kosong', DialogType.ERROR, context);
    } else if (paramEmail.isEmpty) {
      return seeDialog('Email  tidak boleh kosong', DialogType.ERROR, context);
    } else if (paramPassword.isEmpty) {
      return seeDialog(
          'Password  tidak boleh kosong', DialogType.ERROR, context);
    } else {
      final bool isValid = EmailValidator.validate(paramEmail);

      return isValid == false
          ? seeDialog('Format email salah', DialogType.ERROR, context)
          : 'success';
    }
  }

  AwesomeDialog seeDialog(
      String desc, DialogType dialogType, BuildContext context) {
    return AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: dialogType,
        desc: desc,
        btnOkOnPress: () {})
      ..show();
  }
}
