import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SubPageDiemDanh extends StatelessWidget {
  const SubPageDiemDanh({super.key});
  static int idpage = 2;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => MainViewModel().closeMenu(),
        child: Container(
            color: AppConstant.backgroundColor,
            child: const Center(
              child: Text("Diem Danh"),
            )));
  }
}
