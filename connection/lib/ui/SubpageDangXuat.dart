import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SubPageDangXuat extends StatelessWidget {
  const SubPageDangXuat({super.key});
  static int idpage = 6;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => MainViewModel().closeMenu(),
        child: Container(
            color: AppConstant.backgroundColor,
            child: const Center(
              child: Text("Đăng xuất"),
            )));
  }
}