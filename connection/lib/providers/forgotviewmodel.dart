import 'package:flutter/material.dart';
import 'package:connection/repositories/forgot_repository.dart';

class ForgotViewModel with ChangeNotifier {
  final ForgotRepo = ForgotRepository();
  String errormessage = "";
  int status = 0; // 0 chua gui, 1 gui ,2 loi , 3 thanh cong
  Future<void> forgotPassword(String email) async {
    status = 1;
    notifyListeners();
    errormessage = "";
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) {
      status = 2;
      errormessage += "email khong hop le!\n";
      return;
    }
    if (status != 2) {
      if (await ForgotRepo.forgotPassword(email) == true) {
        status = 3;
      } else {
        status = 2;
        errormessage = "Email khong ton tai!";
      }
    }
    notifyListeners();
  }
}
