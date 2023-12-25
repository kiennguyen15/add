import 'package:connection/models/student.dart';
import 'package:connection/repositories/login_repository.dart';
import 'package:connection/repositories/student_repository.dart';
import 'package:connection/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class LoginViewModel with ChangeNotifier {
  String errorMessage = "";
  int status = 0; //  0- not login 1 - waiting 2 - error 3 - login
  LoginRepository loginRepo = LoginRepository();
  // final api = ApiService();
  Future<void> login(String username, String password) async {
    status = 1;
    notifyListeners();
    try {
      var profile = await loginRepo.login(username, password);

      if (profile.token == "") {
        status = 2;
        errorMessage = "Tài khoản hoặc mật khẩu không đúng!";
      } else {
        var student = await StudentRepository().getStudentInfo();
        profile.student = Student.fromStudent(student);
        var user = await UserRepository().getUserInfo();
        profile.user = User.fromUser(user);
        status = 3;
      }
      notifyListeners();
    } catch (e) {}
  }

  void Logout() async {
    if (status == 3) {
      status = 0;
    }
  }
}
