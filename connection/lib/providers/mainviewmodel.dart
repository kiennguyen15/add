import 'package:flutter/material.dart';

class MainViewModel with ChangeNotifier {
  static final MainViewModel _instance = MainViewModel._internal();
  MainViewModel._internal();
  factory MainViewModel() {
    return _instance;
  }

  int menustaturs = 0; // close, 1 open
  int activemenu = 0; // index cuar menu item
  void toggleMenu() {
    if (menustaturs == 0) {
      menustaturs = 1;
    } else {
      menustaturs = 0;
    }
    notifyListeners();
  }

  void setActiveMenu(int index) {
    activemenu = index;
    menustaturs = 0;
    notifyListeners();
  }

  void closeMenu() {
    menustaturs = 0;
    notifyListeners();
  }
}
