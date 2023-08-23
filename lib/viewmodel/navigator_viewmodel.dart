import 'dart:developer';

import 'package:flutter/material.dart';

class NavigatorViewModel extends ChangeNotifier {
  int currentPage = 0;
  //final PageController pageController = PageController();

  moveForward() {
    currentPage++;
    log(currentPage.toString());
    notifyListeners();
  }

  moveBackwards() {
    currentPage--;
    notifyListeners();
  }

  // void setPage(int page) {
  //   currentPage = page;
  //   log(currentPage.toString());
  //   notifyListeners();
  // }
}
